defmodule TabletopCastWeb.RoomController do
  use TabletopCastWeb, :controller

  alias TabletopCast.Rooms
  alias TabletopCast.Rooms.Room

  def index(conn, _params) do
    rooms = Rooms.list_rooms()
    render(conn, "index.html", rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Rooms.change_room(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    case Rooms.create_room(room_params) do
      {:ok, room} ->
        Rooms.create_audio(%{room_id: room.id, num: 1})
        Rooms.create_audio(%{room_id: room.id, num: 2})
        Rooms.create_audio(%{room_id: room.id, num: 3})
        Rooms.create_audio(%{room_id: room.id, num: 4})
        Rooms.create_audio(%{room_id: room.id, num: 5})
        Rooms.create_audio(%{room_id: room.id, num: 6})
        Rooms.create_audio(%{room_id: room.id, num: 7})
        Rooms.create_audio(%{room_id: room.id, num: 8})
        Rooms.create_audio(%{room_id: room.id, num: 9})
        Rooms.create_audio(%{room_id: room.id, num: 10})
        Rooms.create_audio(%{room_id: room.id, num: 11})
        Rooms.create_audio(%{room_id: room.id, num: 12})
        Rooms.create_audio(%{room_id: room.id, num: 13})
        Rooms.create_audio(%{room_id: room.id, num: 14})
        Rooms.create_audio(%{room_id: room.id, num: 15})
        Rooms.create_audio(%{room_id: room.id, num: 16})
        Rooms.create_audio(%{room_id: room.id, num: 17})
        Rooms.create_audio(%{room_id: room.id, num: 18})
        Rooms.create_audio(%{room_id: room.id, num: 19})
        Rooms.create_audio(%{room_id: room.id, num: 20})
        Rooms.create_audio(%{room_id: room.id, num: 21})
        File.mkdir("/home/deploy/media/#{room.slug}")

        conn
        |> put_flash(:info, "Raum erfolgreich angelegt.")
        |> redirect(to: Routes.room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Rooms.get_room_with_audios(id)
    render(conn, "show.html", room: room)
  end

  def edit(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)
    changeset = Rooms.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Rooms.get_room!(id)

    case Rooms.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Raum erfolgreich aktualisiert.")
        |> redirect(to: Routes.room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)
    {:ok, _room} = Rooms.delete_room(room)
    File.rm_rf("/home/deploy/media/#{room.slug}")

    conn
    |> put_flash(:info, "Raum erfolgreich gelöscht.")
    |> redirect(to: Routes.room_path(conn, :index))
  end
end
