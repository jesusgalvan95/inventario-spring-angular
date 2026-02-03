import { Component, signal } from '@angular/core';
import { ProductoLista } from "./producto-lista/producto-lista";
import { RouterLink, RouterLinkActive, RouterModule, RouterOutlet } from "@angular/router";

@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.html',
  imports: [ RouterLink, RouterLinkActive, RouterOutlet, RouterModule]
})
export class App {
  protected readonly title = signal('inventario-app');
}
