Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE5788A1AE
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Mar 2024 14:23:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TDpPvYxL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V3DC332hkz3cnv
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Mar 2024 00:23:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TDpPvYxL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b35; helo=mail-yb1-xb35.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V3DC026c3z3bx0
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Mar 2024 00:23:08 +1100 (AEDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-dc742543119so4004959276.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 25 Mar 2024 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711372985; x=1711977785; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTu/BkO4gN2IfYdC+g7TYVUi+jDorueqR+dF6w7YScg=;
        b=TDpPvYxLvbDNmGliPI5ChRMN4hZDX8nXqdLpx6WqmPFOvAZJAmcMfWABjXvj0vwxer
         VtC+SVC2rXvFUXAHDLcmyKAiLG0rgzUeb3OwD6FHKqfMx8Vfc2ivr0A/RcVvL9Todblq
         45UK4GrTt+cQTVPghTKb4GzraApb9QNdvj5nHjoD5Hv4+t+zheY6UlMv8mc1nw4Ve08Q
         qJYecVwwf0jqKYZuv4+4hJt9ux8Lo+z1CQNX25mlHf39TLZD1FrykWVQwNDAt0JUqwjm
         JK9bxK62Iqlig3fxhgYO7PPqxv1+vPNO4ffnXQrJo59Fy/MII55klWqhLGLvl32hrYca
         4KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372985; x=1711977785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTu/BkO4gN2IfYdC+g7TYVUi+jDorueqR+dF6w7YScg=;
        b=hwlLb1I+8lcUVKX/mwfGfaF05f7uP2m9htNqkb9ayBcXbdq2iOu1TNV+FLhzsaMRP7
         +0cVM/SDGCb74hNbSbeQf2+lzJ3E5k6lWRH+EtPLTHheJm8nkvR7cfkETJjIWOkNRb/Y
         6/5Y5H3cZm8kPjKcEJ+6r9EAJ+/Gqrv353PWNXhah/R+HpdcQOLDy4QbDhhFw3FgFsFL
         dYRvc8JoH6dClxmqv8w9+cjylz0eXqBuSEZ8APjvjlXtclfg+XfxtjW5I4G3SNUNWIA0
         OnCWvohITI3y0r7lckWoyowk6ksac5NWYO8uyQHSPVpIWPzPAzT6tITwHp3nvO26dUHz
         /ZPQ==
X-Gm-Message-State: AOJu0YyCc9Unf+wrq63fi5TB5uTa1C1tYCL7IdFLLjDsJ/fX6CTHJk+D
	nKjDzL2xFQ3PE46sSCdzmV9yGeqxrO98ZCxJoGdKSDQSkFhm8U0A21KqStW8H0c36Op4T0QEyHR
	ltD2fG7YV02TX5q0NhkGWl8MUd/w=
X-Google-Smtp-Source: AGHT+IH26dSKXhbN0qYmayhyHkAAdeJhcZ5hda9Dcykpq83kcZbN0wvly1UeujrnkCE62cmRUAbWmidDDzYFCxDZ5+U=
X-Received: by 2002:a25:8703:0:b0:dcb:e432:cb06 with SMTP id
 a3-20020a258703000000b00dcbe432cb06mr4422404ybl.29.1711372985001; Mon, 25 Mar
 2024 06:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240323173902.3882401-1-zhaoyifan@sjtu.edu.cn> <20240323173902.3882401-2-zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240323173902.3882401-2-zhaoyifan@sjtu.edu.cn>
From: Huang Jianan <jnhuang95@gmail.com>
Date: Mon, 25 Mar 2024 21:22:48 +0800
Message-ID: <CAJfKizoQ-vm2DSEy6CFhDWLLi_oZXFmskkLVk+OpTwMZWze-BQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] erofs-utils: lib: split function logic in inode.c
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Jianan Huang <jnhuang95@gmail.com>

Thanks.

Yifan Zhao <zhaoyifan@sjtu.edu.cn> =E4=BA=8E2024=E5=B9=B43=E6=9C=8824=E6=97=
=A5=E5=91=A8=E6=97=A5 01:39=E5=86=99=E9=81=93=EF=BC=9A
>
> This patch splits part of the logic in function erofs_mkfs_build_tree()
> and erofs_mkfs_build_tree_from_path() into several new functions. This
> is in preparation for the upcoming inter-file multi-threaded compression
> feature.
>
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>  lib/inode.c | 161 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 101 insertions(+), 60 deletions(-)
>
> diff --git a/lib/inode.c b/lib/inode.c
> index 4c29aa7..36ee58d 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -477,20 +477,24 @@ static int write_uncompressed_file_from_fd(struct e=
rofs_inode *inode, int fd)
>         return 0;
>  }
>
> +static int erofs_write_chunked_file(struct erofs_inode *inode, int fd, u=
64 fpos)
> +{
> +       inode->u.chunkbits =3D cfg.c_chunkbits;
> +       /* chunk indexes when explicitly specified */
> +       inode->u.chunkformat =3D 0;
> +       if (cfg.c_force_chunkformat =3D=3D FORCE_INODE_CHUNK_INDEXES)
> +               inode->u.chunkformat =3D EROFS_CHUNK_FORMAT_INDEXES;
> +       return erofs_blob_write_chunked_file(inode, fd, fpos);
> +}
> +
>  int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
>  {
>         int ret;
>
>         DBG_BUGON(!inode->i_size);
>
> -       if (cfg.c_chunkbits) {
> -               inode->u.chunkbits =3D cfg.c_chunkbits;
> -               /* chunk indexes when explicitly specified */
> -               inode->u.chunkformat =3D 0;
> -               if (cfg.c_force_chunkformat =3D=3D FORCE_INODE_CHUNK_INDE=
XES)
> -                       inode->u.chunkformat =3D EROFS_CHUNK_FORMAT_INDEX=
ES;
> -               return erofs_blob_write_chunked_file(inode, fd, fpos);
> -       }
> +       if (cfg.c_chunkbits)
> +               return erofs_write_chunked_file(inode, fd, fpos);
>
>         if (cfg.c_compr_opts[0].alg && erofs_file_is_compressible(inode))=
 {
>                 ret =3D erofs_write_compressed_file(inode, fd, fpos);
> @@ -1096,52 +1100,58 @@ static void erofs_fixup_meta_blkaddr(struct erofs=
_inode *rootdir)
>         rootdir->nid =3D (off - meta_offset) >> EROFS_ISLOTBITS;
>  }
>
> -static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_he=
ad *dirs)
> +
> +static int erofs_mkfs_handle_symlink(struct erofs_inode *inode)
>  {
> -       int ret;
> -       DIR *_dir;
> -       struct dirent *dp;
> -       struct erofs_dentry *d;
> -       unsigned int nr_subdirs, i_nlink;
> +       int ret =3D 0;
> +       char *const symlink =3D malloc(inode->i_size);
>
> -       ret =3D erofs_scan_file_xattrs(dir);
> -       if (ret < 0)
> -               return ret;
> +       if (!symlink)
> +               return -ENOMEM;
> +       ret =3D readlink(inode->i_srcpath, symlink, inode->i_size);
> +       if (ret < 0) {
> +               free(symlink);
> +               return -errno;
> +       }
> +       ret =3D erofs_write_file_from_buffer(inode, symlink);
> +       free(symlink);
>
> -       ret =3D erofs_prepare_xattr_ibody(dir);
> -       if (ret < 0)
> -               return ret;
> +       return ret;
> +}
>
> -       if (!S_ISDIR(dir->i_mode)) {
> -               if (S_ISLNK(dir->i_mode)) {
> -                       char *const symlink =3D malloc(dir->i_size);
> +static int erofs_mkfs_handle_file(struct erofs_inode *inode)
> +{
> +       int ret =3D 0;
>
> -                       if (!symlink)
> -                               return -ENOMEM;
> -                       ret =3D readlink(dir->i_srcpath, symlink, dir->i_=
size);
> -                       if (ret < 0) {
> -                               free(symlink);
> -                               return -errno;
> -                       }
> -                       ret =3D erofs_write_file_from_buffer(dir, symlink=
);
> -                       free(symlink);
> -               } else if (dir->i_size) {
> -                       int fd =3D open(dir->i_srcpath, O_RDONLY | O_BINA=
RY);
> -                       if (fd < 0)
> -                               return -errno;
> +       if (S_ISLNK(inode->i_mode)) {
> +               ret =3D erofs_mkfs_handle_symlink(inode);
> +       } else if (inode->i_size) {
> +               int fd =3D open(inode->i_srcpath, O_RDONLY | O_BINARY);
>
> -                       ret =3D erofs_write_file(dir, fd, 0);
> -                       close(fd);
> -               } else {
> -                       ret =3D 0;
> -               }
> -               if (ret)
> -                       return ret;
> +               if (fd < 0)
> +                       return -errno;
>
> -               erofs_prepare_inode_buffer(dir);
> -               erofs_write_tail_end(dir);
> -               return 0;
> +               ret =3D erofs_write_file(inode, fd, 0);
> +               close(fd);
> +       } else {
> +               ret =3D 0;
>         }
> +       if (ret)
> +               return ret;
> +
> +       erofs_prepare_inode_buffer(inode);
> +       erofs_write_tail_end(inode);
> +       return 0;
> +}
> +
> +static int erofs_mkfs_handle_dir(struct erofs_inode *dir,
> +                                struct list_head *dirs)
> +{
> +       int ret;
> +       DIR *_dir;
> +       struct dirent *dp;
> +       struct erofs_dentry *d;
> +       unsigned int nr_subdirs =3D 0, i_nlink;
>
>         _dir =3D opendir(dir->i_srcpath);
>         if (!_dir) {
> @@ -1253,6 +1263,49 @@ err_closedir:
>         return ret;
>  }
>
> +static void erofs_mkfs_print_progressinfo(struct erofs_inode *inode)
> +{
> +       char *trimmed;
> +
> +       trimmed =3D erofs_trim_for_progressinfo(erofs_fspath(inode->i_src=
path),
> +                                             sizeof("Processing  ...") -=
 1);
> +       erofs_update_progressinfo("Processing %s ...", trimmed);
> +       free(trimmed);
> +}
> +
> +static void erofs_mkfs_dumpdir(struct erofs_inode *dumpdir)
> +{
> +       struct erofs_inode *inode;
> +
> +       while (dumpdir) {
> +               inode =3D dumpdir;
> +               erofs_write_dir_file(inode);
> +               erofs_write_tail_end(inode);
> +               inode->bh->op =3D &erofs_write_inode_bhops;
> +               dumpdir =3D inode->next_dirwrite;
> +               erofs_iput(inode);
> +       }
> +}
> +
> +static int erofs_mkfs_build_tree(struct erofs_inode *dir,
> +                                struct list_head *dirs)
> +{
> +       int ret;
> +
> +       ret =3D erofs_scan_file_xattrs(dir);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D erofs_prepare_xattr_ibody(dir);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (S_ISDIR(dir->i_mode))
> +               return erofs_mkfs_handle_dir(dir, dirs);
> +       else
> +               return erofs_mkfs_handle_file(dir);
> +}
> +
>  struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
>  {
>         LIST_HEAD(dirs);
> @@ -1269,17 +1322,12 @@ struct erofs_inode *erofs_mkfs_build_tree_from_pa=
th(const char *path)
>         dumpdir =3D NULL;
>         do {
>                 int err;
> -               char *trimmed;
>
>                 inode =3D list_first_entry(&dirs, struct erofs_inode, i_s=
ubdirs);
>                 list_del(&inode->i_subdirs);
>                 init_list_head(&inode->i_subdirs);
>
> -               trimmed =3D erofs_trim_for_progressinfo(
> -                               erofs_fspath(inode->i_srcpath),
> -                               sizeof("Processing  ...") - 1);
> -               erofs_update_progressinfo("Processing %s ...", trimmed);
> -               free(trimmed);
> +               erofs_mkfs_print_progressinfo(inode);
>
>                 err =3D erofs_mkfs_build_tree(inode, &dirs);
>                 if (err) {
> @@ -1295,14 +1343,7 @@ struct erofs_inode *erofs_mkfs_build_tree_from_pat=
h(const char *path)
>                 }
>         } while (!list_empty(&dirs));
>
> -       while (dumpdir) {
> -               inode =3D dumpdir;
> -               erofs_write_dir_file(inode);
> -               erofs_write_tail_end(inode);
> -               inode->bh->op =3D &erofs_write_inode_bhops;
> -               dumpdir =3D inode->next_dirwrite;
> -               erofs_iput(inode);
> -       }
> +       erofs_mkfs_dumpdir(dumpdir);
>         return root;
>  }
>
> --
> 2.44.0
>
