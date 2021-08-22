import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { PostService } from 'src/app/services/post.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  posts: Post[] = [];

  constructor(private postService: PostService) { }


  ngOnInit(): void {
    this.loadAllPosts();
  }

  loadAllPosts() {
    this.postService.index().subscribe(
      data => { this.posts = data;},

      error => { console.error('Error retrieving posts from postService: ' + error);}
    );
  }
  postHasImage(i: number) {
  if(this.posts[i].imageUrl === null){
    return false;
  } else {
    return true;
  }
  }
}
