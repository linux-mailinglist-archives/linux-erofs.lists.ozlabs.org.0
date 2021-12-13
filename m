Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA134737BD
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Dec 2021 23:42:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCc366FRyz2ymv
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 09:42:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639435362;
	bh=ucFXVK/LznYqnoNbX/QCpJOMBBBtmustsr3f+M4l/Nc=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=MtHb5Wm73NqDZxw3gwom/IMGKdpGj+vGGtAeZsR9f8HtpyrXj3pbvZgxrU/21iGcY
	 tnwJVlmf3WtPbK3BfxE5yMn5UwWM8wNmC9ucjQIveh9hsAazMjkluAkgVgj7Deoa+r
	 vwBDl6r3/BRjpZaU2LSLbyU+XVLUkgr0ulDfWttSZvjy6NHo574UXArjs2oOG4eInl
	 H6U0yAxfIgj7ut7MxDpbHkVCvgjN6xie2uAPYox6c/76eyvR1H5XYH2SZGZjnGL31C
	 uss+LdzB0XZKEAWdY2RblgV0UNBOTakqmyGmzZLhXoTiGIwHIz4+lIxOnzK4Ytamk4
	 72mdt7ngUBEqA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::735;
 helo=mail-qk1-x735.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=G7hZvDIO; dkim-atps=neutral
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCc313M7xz2yJV
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 09:42:35 +1100 (AEDT)
Received: by mail-qk1-x735.google.com with SMTP id de30so15388900qkb.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 14:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ucFXVK/LznYqnoNbX/QCpJOMBBBtmustsr3f+M4l/Nc=;
 b=AOLW6e20BVnsU7lwqSAERnqiR2a9f7js8FArgW9x9jfV+NXgQU2lX7ydZskohZNcs7
 C2BX/QnDcdgFoGEjkqkdQ3uK+WtYK2J65RCdVYbZdhBMM2IottsLXOosND7Lan6CLUQc
 TG3hd1k4xxrvm2W4Xb7VNAMYkA5X2tQs8q1dhAz2NAsZk8TqPdQIXUXMHafA9dfS72Q0
 r76jCODl5o1UOiMUz9iAn0B3aTnItxqUhYJ5JgsYWQ3ijC5WlPcY1Uc5N6YjcoVg0/gf
 uT74dXK9d+//36K+Sa1noQoqMzsj7bB1qUYH4VuVBkbkb5wDSuzSB97cYNnGwZFWiag5
 lfYQ==
X-Gm-Message-State: AOAM532Igu01PiNKrwrn6hcdnv7TspkhXRDf3/kKTEG0peklG4F33X1v
 s9hPBD5jQjOXnlivMQ3GqM5FaPQbFuLhpJV+/JKht023X0s=
X-Google-Smtp-Source: ABdhPJyxu2PeV/pOusvpngMHQ5gABEE7ViR1Trl129eMGVKLvvaj3P2YUhRt+FiVefdkA0bYJS3Bm0A4XEfgIc241wY=
X-Received: by 2002:a05:620a:440b:: with SMTP id
 v11mr1027542qkp.160.1639435350026; 
 Mon, 13 Dec 2021 14:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20211209004659.4161847-1-zhangkelvin@google.com>
 <20211209012118.4175351-1-zhangkelvin@google.com>
 <20211209012118.4175351-3-zhangkelvin@google.com>
In-Reply-To: <20211209012118.4175351-3-zhangkelvin@google.com>
Date: Mon, 13 Dec 2021 14:42:19 -0800
Message-ID: <CAOSmRzif-ZjzdrMqQs_-hwRex5uPTLDTraB5d5tcjXf=WEjCbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Add API to iterate over inodes in EROFS
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000ac5c0805d30ec99e"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000ac5c0805d30ec99e
Content-Type: text/plain; charset="UTF-8"

Friendly ping

On Wed, Dec 8, 2021 at 5:21 PM Kelvin Zhang <zhangkelvin@google.com> wrote:

> Change-Id: Ia35708080a72ee204eaaddfc670d3cb8023a078c
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  include/erofs/iterate.h |  57 +++++++++++++
>  lib/Makefile.am         |   2 +-
>  lib/iterate.c           | 173 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 231 insertions(+), 1 deletion(-)
>  create mode 100644 include/erofs/iterate.h
>  create mode 100644 lib/iterate.c
>
> diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
> new file mode 100644
> index 0000000..96171a7
> --- /dev/null
> +++ b/include/erofs/iterate.h
> @@ -0,0 +1,57 @@
> +//
> +// Copyright (C) 2021 The Android Open Source Project
> +//
> +// Licensed under the Apache License, Version 2.0 (the "License");
> +// you may not use this file except in compliance with the License.
> +// You may obtain a copy of the License at
> +//
> +//      http://www.apache.org/licenses/LICENSE-2.0
> +//
> +// Unless required by applicable law or agreed to in writing, software
> +// distributed under the License is distributed on an "AS IS" BASIS,
> +// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> implied.
> +// See the License for the specific language governing permissions and
> +// limitations under the License.
> +//
> +
> +#ifndef ITERATE_ITERATE
> +#define ITERATE_ITERATE
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +
> +#include "erofs/io.h"
> +#include "erofs/print.h"
> +
> +
> +struct erofs_inode_info {
> +  uint64_t inode_id;
> +  const char* name;
> +  bool is_reg_file;
> +  u64 compressed_size;
> +  u64 uncompressed_size;
> +  struct erofs_inode* inode;
> +  void* arg;
> +};
> +// Callback function for iterating over inodes of EROFS
> +
> +typedef bool (*ErofsIterCallback)(struct erofs_inode_info);
> +
> +int erofs_iterate_dir(const struct erofs_sb_info* sbi,
> +                   erofs_nid_t nid,
> +                   erofs_nid_t parent_nid,
> +                   ErofsIterCallback cb,
> +                   void* arg);
> +int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
> +                        ErofsIterCallback cbg,
> +                        void* arg);
> +int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif  // ITERATE_ITERATE
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 67ba798..20c0e4f 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -27,7 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>  noinst_HEADERS += compressor.h
>  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c
> exclude.c \
>                       namei.c data.c compress.c compressor.c zmap.c
> decompress.c \
> -                     compress_hints.c hashmap.c sha256.c blobchunk.c
> +                     compress_hints.c hashmap.c sha256.c blobchunk.c
> iterate.c
>  liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
>  if ENABLE_LZ4
>  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> diff --git a/lib/iterate.c b/lib/iterate.c
> new file mode 100644
> index 0000000..1a10ec1
> --- /dev/null
> +++ b/lib/iterate.c
> @@ -0,0 +1,173 @@
> +//
> +// Copyright (C) 2021 The Android Open Source Project
> +//
> +// Licensed under the Apache License, Version 2.0 (the "License");
> +// you may not use this file except in compliance with the License.
> +// You may obtain a copy of the License at
> +//
> +//      http://www.apache.org/licenses/LICENSE-2.0
> +//
> +// Unless required by applicable law or agreed to in writing, software
> +// distributed under the License is distributed on an "AS IS" BASIS,
> +// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> implied.
> +// See the License for the specific language governing permissions and
> +// limitations under the License.
> +//
> +
> +#include "erofs/internal.h"
> +#include "erofs_fs.h"
> +#include "erofs/print.h"
> +#include "erofs/iterate.h"
> +
> +static int erofs_read_dirent(const struct erofs_sb_info* sbi,
> +                             const struct erofs_dirent* de,
> +                             erofs_nid_t nid,
> +                             erofs_nid_t parent_nid,
> +                             const char* dname,
> +                             ErofsIterCallback cb,
> +                             void* arg) {
> +  int err;
> +  erofs_off_t occupied_size = 0;
> +  struct erofs_inode inode = {.nid = de->nid};
> +  err = erofs_read_inode_from_disk(&inode);
> +  if (err) {
> +    erofs_err("read file inode from disk failed!");
> +    return err;
> +  }
> +  err = erofs_get_occupied_size(&inode, &occupied_size);
> +  if (err) {
> +    erofs_err("get file size failed\n");
> +    return err;
> +  }
> +  char buf[PATH_MAX + 1];
> +  erofs_get_inode_name(sbi, de->nid, buf, PATH_MAX + 1);
> +  struct erofs_inode_info info = {
> +      .inode_id = de->nid,
> +      .name = buf,
> +      .is_reg_file = de->file_type == EROFS_FT_REG_FILE,
> +      .compressed_size = occupied_size,
> +      .uncompressed_size = inode.i_size,
> +      .inode = &inode,
> +      .arg = arg};
> +  cb(info);
> +  if ((de->file_type == EROFS_FT_DIR) && de->nid != nid &&
> +      de->nid != parent_nid) {
> +    err = erofs_iterate_dir(sbi, de->nid, nid, cb, arg);
> +    if (err) {
> +      erofs_err("parse dir nid %u error occurred\n",
> +                (unsigned int)(de->nid));
> +      return err;
> +    }
> +  }
> +  return 0;
> +}
> +
> +static inline int erofs_checkdirent(const struct erofs_dirent* de,
> +                                    const struct erofs_dirent* last_de,
> +                                    u32 maxsize,
> +                                    const char* dname) {
> +  int dname_len;
> +  unsigned int nameoff = le16_to_cpu(de->nameoff);
> +  if (nameoff < sizeof(struct erofs_dirent) || nameoff >= PAGE_SIZE) {
> +    erofs_err("invalid de[0].nameoff %u @ nid %llu", nameoff, de->nid |
> 0ULL);
> +    return -EFSCORRUPTED;
> +  }
> +  dname_len = (de + 1 >= last_de) ? strnlen(dname, maxsize - nameoff)
> +                                  : le16_to_cpu(de[1].nameoff) - nameoff;
> +  /* a corrupted entry is found */
> +  if (nameoff + dname_len > maxsize || dname_len > EROFS_NAME_LEN) {
> +    erofs_err("bogus dirent @ nid %llu", le64_to_cpu(de->nid) | 0ULL);
> +    DBG_BUGON(1);
> +    return -EFSCORRUPTED;
> +  }
> +  if (de->file_type >= EROFS_FT_MAX) {
> +    erofs_err("invalid file type %u", (unsigned int)(de->nid));
> +    return -EFSCORRUPTED;
> +  }
> +  return dname_len;
> +}
> +
> +int erofs_iterate_dir(const struct erofs_sb_info* sbi,
> +                   erofs_nid_t nid,
> +                   erofs_nid_t parent_nid,
> +                   ErofsIterCallback cb,
> +                   void* arg) {
> +  int err;
> +  erofs_off_t offset;
> +  char buf[EROFS_BLKSIZ];
> +  struct erofs_inode vi = {.nid = nid};
> +  err = erofs_read_inode_from_disk(&vi);
> +  if (err)
> +    return err;
> +  struct erofs_inode_info inode_info = {
> +      .inode_id = nid,
> +      .name = buf,
> +      .is_reg_file = false,
> +      .compressed_size = vi.i_size,
> +      .uncompressed_size = vi.i_size,
> +      .inode = &vi,
> +      .arg = arg,
> +  };
> +  err = erofs_get_inode_name(sbi, nid, buf, EROFS_BLKSIZ);
> +  cb(inode_info);
> +  if (err) {
> +    return err;
> +  }
> +  offset = 0;
> +  while (offset < vi.i_size) {
> +    erofs_off_t maxsize = min_t(erofs_off_t, vi.i_size - offset,
> EROFS_BLKSIZ);
> +    const struct erofs_dirent* de = (const struct erofs_dirent*)(buf);
> +    struct erofs_dirent* end;
> +    unsigned int nameoff;
> +    err = erofs_pread(&vi, buf, maxsize, offset);
> +    if (err)
> +      return err;
> +    nameoff = le16_to_cpu(de->nameoff);
> +    end = (struct erofs_dirent*)(buf + nameoff);
> +    while (de < end) {
> +      const char* dname;
> +      int ret;
> +      /* skip "." and ".." dentry */
> +      if (de->nid == nid || de->nid == parent_nid) {
> +        de++;
> +        continue;
> +      }
> +      dname = (char*)buf + nameoff;
> +      ret = erofs_checkdirent(de, end, maxsize, dname);
> +      if (ret < 0)
> +        return ret;
> +      ret = erofs_read_dirent(sbi, de, nid, parent_nid, dname, cb, arg);
> +      if (ret < 0)
> +        return ret;
> +      ++de;
> +    }
> +    offset += maxsize;
> +  }
> +  return 0;
> +}
> +
> +int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size)
> {
> +  *size = 0;
> +  switch (inode->datalayout) {
> +    case EROFS_INODE_FLAT_INLINE:
> +    case EROFS_INODE_FLAT_PLAIN:
> +    case EROFS_INODE_CHUNK_BASED:
> +      *size = inode->i_size;
> +      break;
> +    case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +    case EROFS_INODE_FLAT_COMPRESSION:
> +      *size = inode->u.i_blocks * EROFS_BLKSIZ;
> +      break;
> +    default:
> +      erofs_err("unknown datalayout");
> +      return -1;
> +  }
> +  return 0;
> +}
> +
> +int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
> +                        ErofsIterCallback cb,
> +                        void* arg) {
> +  return erofs_iterate_dir(sbi, sbi->root_nid, sbi->root_nid, cb, arg);
> +}
> +
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
>

-- 
Sincerely,

Kelvin Zhang

--000000000000ac5c0805d30ec99e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Friendly ping</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Dec 8, 2021 at 5:21 PM Kelvin Zhang &=
lt;<a href=3D"mailto:zhangkelvin@google.com">zhangkelvin@google.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Change-I=
d: Ia35708080a72ee204eaaddfc670d3cb8023a078c<br>
Signed-off-by: Kelvin Zhang &lt;<a href=3D"mailto:zhangkelvin@google.com" t=
arget=3D"_blank">zhangkelvin@google.com</a>&gt;<br>
---<br>
=C2=A0include/erofs/iterate.h |=C2=A0 57 +++++++++++++<br>
=C2=A0lib/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
=C2=A0lib/iterate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 173 +++++++++=
+++++++++++++++++++++++++++++++<br>
=C2=A03 files changed, 231 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 include/erofs/iterate.h<br>
=C2=A0create mode 100644 lib/iterate.c<br>
<br>
diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h<br>
new file mode 100644<br>
index 0000000..96171a7<br>
--- /dev/null<br>
+++ b/include/erofs/iterate.h<br>
@@ -0,0 +1,57 @@<br>
+//<br>
+// Copyright (C) 2021 The Android Open Source Project<br>
+//<br>
+// Licensed under the Apache License, Version 2.0 (the &quot;License&quot;=
);<br>
+// you may not use this file except in compliance with the License.<br>
+// You may obtain a copy of the License at<br>
+//<br>
+//=C2=A0 =C2=A0 =C2=A0 <a href=3D"http://www.apache.org/licenses/LICENSE-2=
.0" rel=3D"noreferrer" target=3D"_blank">http://www.apache.org/licenses/LIC=
ENSE-2.0</a><br>
+//<br>
+// Unless required by applicable law or agreed to in writing, software<br>
+// distributed under the License is distributed on an &quot;AS IS&quot; BA=
SIS,<br>
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied=
.<br>
+// See the License for the specific language governing permissions and<br>
+// limitations under the License.<br>
+//<br>
+<br>
+#ifndef ITERATE_ITERATE<br>
+#define ITERATE_ITERATE<br>
+<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
+<br>
+#include &quot;erofs/io.h&quot;<br>
+#include &quot;erofs/print.h&quot;<br>
+<br>
+<br>
+struct erofs_inode_info {<br>
+=C2=A0 uint64_t inode_id;<br>
+=C2=A0 const char* name;<br>
+=C2=A0 bool is_reg_file;<br>
+=C2=A0 u64 compressed_size;<br>
+=C2=A0 u64 uncompressed_size;<br>
+=C2=A0 struct erofs_inode* inode;<br>
+=C2=A0 void* arg;<br>
+};<br>
+// Callback function for iterating over inodes of EROFS<br>
+<br>
+typedef bool (*ErofsIterCallback)(struct erofs_inode_info);<br>
+<br>
+int erofs_iterate_dir(const struct erofs_sb_info* sbi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs=
_nid_t nid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs=
_nid_t parent_nid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Erofs=
IterCallback cb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void*=
 arg);<br>
+int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ErofsIterCallback cbg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void* arg);<br>
+int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size);=
<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
+#endif=C2=A0 // ITERATE_ITERATE<br>
diff --git a/lib/Makefile.am b/lib/Makefile.am<br>
index 67ba798..20c0e4f 100644<br>
--- a/lib/Makefile.am<br>
+++ b/lib/Makefile.am<br>
@@ -27,7 +27,7 @@ noinst_HEADERS =3D $(top_srcdir)/include/erofs_fs.h \<br>
=C2=A0noinst_HEADERS +=3D compressor.h<br>
=C2=A0liberofs_la_SOURCES =3D config.c io.c cache.c super.c inode.c xattr.c=
 exclude.c \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 namei.c data.c compress.c compressor.c zmap.c decompress.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0compress_hints.c hashmap.c sha256.c blobchunk.c<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0compress_hints.c hashmap.c sha256.c blobchunk.c iterate.c<br>
=C2=A0liberofs_la_CFLAGS =3D -Wall -Werror -I$(top_srcdir)/include<br>
=C2=A0if ENABLE_LZ4<br>
=C2=A0liberofs_la_CFLAGS +=3D ${LZ4_CFLAGS}<br>
diff --git a/lib/iterate.c b/lib/iterate.c<br>
new file mode 100644<br>
index 0000000..1a10ec1<br>
--- /dev/null<br>
+++ b/lib/iterate.c<br>
@@ -0,0 +1,173 @@<br>
+//<br>
+// Copyright (C) 2021 The Android Open Source Project<br>
+//<br>
+// Licensed under the Apache License, Version 2.0 (the &quot;License&quot;=
);<br>
+// you may not use this file except in compliance with the License.<br>
+// You may obtain a copy of the License at<br>
+//<br>
+//=C2=A0 =C2=A0 =C2=A0 <a href=3D"http://www.apache.org/licenses/LICENSE-2=
.0" rel=3D"noreferrer" target=3D"_blank">http://www.apache.org/licenses/LIC=
ENSE-2.0</a><br>
+//<br>
+// Unless required by applicable law or agreed to in writing, software<br>
+// distributed under the License is distributed on an &quot;AS IS&quot; BA=
SIS,<br>
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied=
.<br>
+// See the License for the specific language governing permissions and<br>
+// limitations under the License.<br>
+//<br>
+<br>
+#include &quot;erofs/internal.h&quot;<br>
+#include &quot;erofs_fs.h&quot;<br>
+#include &quot;erofs/print.h&quot;<br>
+#include &quot;erofs/iterate.h&quot;<br>
+<br>
+static int erofs_read_dirent(const struct erofs_sb_info* sbi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct erofs_dirent* de,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t nid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t parent_nid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char* dname,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ErofsIterCallback cb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void* arg) {<br>
+=C2=A0 int err;<br>
+=C2=A0 erofs_off_t occupied_size =3D 0;<br>
+=C2=A0 struct erofs_inode inode =3D {.nid =3D de-&gt;nid};<br>
+=C2=A0 err =3D erofs_read_inode_from_disk(&amp;inode);<br>
+=C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 erofs_err(&quot;read file inode from disk failed!&quot;);<br=
>
+=C2=A0 =C2=A0 return err;<br>
+=C2=A0 }<br>
+=C2=A0 err =3D erofs_get_occupied_size(&amp;inode, &amp;occupied_size);<br=
>
+=C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 erofs_err(&quot;get file size failed\n&quot;);<br>
+=C2=A0 =C2=A0 return err;<br>
+=C2=A0 }<br>
+=C2=A0 char buf[PATH_MAX + 1];<br>
+=C2=A0 erofs_get_inode_name(sbi, de-&gt;nid, buf, PATH_MAX + 1);<br>
+=C2=A0 struct erofs_inode_info info =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 .inode_id =3D de-&gt;nid,<br>
+=C2=A0 =C2=A0 =C2=A0 .name =3D buf,<br>
+=C2=A0 =C2=A0 =C2=A0 .is_reg_file =3D de-&gt;file_type =3D=3D EROFS_FT_REG=
_FILE,<br>
+=C2=A0 =C2=A0 =C2=A0 .compressed_size =3D occupied_size,<br>
+=C2=A0 =C2=A0 =C2=A0 .uncompressed_size =3D inode.i_size,<br>
+=C2=A0 =C2=A0 =C2=A0 .inode =3D &amp;inode,<br>
+=C2=A0 =C2=A0 =C2=A0 .arg =3D arg};<br>
+=C2=A0 cb(info);<br>
+=C2=A0 if ((de-&gt;file_type =3D=3D EROFS_FT_DIR) &amp;&amp; de-&gt;nid !=
=3D nid &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 de-&gt;nid !=3D parent_nid) {<br>
+=C2=A0 =C2=A0 err =3D erofs_iterate_dir(sbi, de-&gt;nid, nid, cb, arg);<br=
>
+=C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 erofs_err(&quot;parse dir nid %u error occurred\n&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (unsigned int)(de-=
&gt;nid));<br>
+=C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 }<br>
+=C2=A0 return 0;<br>
+}<br>
+<br>
+static inline int erofs_checkdirent(const struct erofs_dirent* de,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct erofs_dir=
ent* last_de,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 maxsize,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char* dname) {<b=
r>
+=C2=A0 int dname_len;<br>
+=C2=A0 unsigned int nameoff =3D le16_to_cpu(de-&gt;nameoff);<br>
+=C2=A0 if (nameoff &lt; sizeof(struct erofs_dirent) || nameoff &gt;=3D PAG=
E_SIZE) {<br>
+=C2=A0 =C2=A0 erofs_err(&quot;invalid de[0].nameoff %u @ nid %llu&quot;, n=
ameoff, de-&gt;nid | 0ULL);<br>
+=C2=A0 =C2=A0 return -EFSCORRUPTED;<br>
+=C2=A0 }<br>
+=C2=A0 dname_len =3D (de + 1 &gt;=3D last_de) ? strnlen(dname, maxsize - n=
ameoff)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : le16_to_cpu(de[1].nameoff) =
- nameoff;<br>
+=C2=A0 /* a corrupted entry is found */<br>
+=C2=A0 if (nameoff + dname_len &gt; maxsize || dname_len &gt; EROFS_NAME_L=
EN) {<br>
+=C2=A0 =C2=A0 erofs_err(&quot;bogus dirent @ nid %llu&quot;, le64_to_cpu(d=
e-&gt;nid) | 0ULL);<br>
+=C2=A0 =C2=A0 DBG_BUGON(1);<br>
+=C2=A0 =C2=A0 return -EFSCORRUPTED;<br>
+=C2=A0 }<br>
+=C2=A0 if (de-&gt;file_type &gt;=3D EROFS_FT_MAX) {<br>
+=C2=A0 =C2=A0 erofs_err(&quot;invalid file type %u&quot;, (unsigned int)(d=
e-&gt;nid));<br>
+=C2=A0 =C2=A0 return -EFSCORRUPTED;<br>
+=C2=A0 }<br>
+=C2=A0 return dname_len;<br>
+}<br>
+<br>
+int erofs_iterate_dir(const struct erofs_sb_info* sbi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs=
_nid_t nid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs=
_nid_t parent_nid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Erofs=
IterCallback cb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void*=
 arg) {<br>
+=C2=A0 int err;<br>
+=C2=A0 erofs_off_t offset;<br>
+=C2=A0 char buf[EROFS_BLKSIZ];<br>
+=C2=A0 struct erofs_inode vi =3D {.nid =3D nid};<br>
+=C2=A0 err =3D erofs_read_inode_from_disk(&amp;vi);<br>
+=C2=A0 if (err)<br>
+=C2=A0 =C2=A0 return err;<br>
+=C2=A0 struct erofs_inode_info inode_info =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 .inode_id =3D nid,<br>
+=C2=A0 =C2=A0 =C2=A0 .name =3D buf,<br>
+=C2=A0 =C2=A0 =C2=A0 .is_reg_file =3D false,<br>
+=C2=A0 =C2=A0 =C2=A0 .compressed_size =3D vi.i_size,<br>
+=C2=A0 =C2=A0 =C2=A0 .uncompressed_size =3D vi.i_size,<br>
+=C2=A0 =C2=A0 =C2=A0 .inode =3D &amp;vi,<br>
+=C2=A0 =C2=A0 =C2=A0 .arg =3D arg,<br>
+=C2=A0 };<br>
+=C2=A0 err =3D erofs_get_inode_name(sbi, nid, buf, EROFS_BLKSIZ);<br>
+=C2=A0 cb(inode_info);<br>
+=C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 return err;<br>
+=C2=A0 }<br>
+=C2=A0 offset =3D 0;<br>
+=C2=A0 while (offset &lt; vi.i_size) {<br>
+=C2=A0 =C2=A0 erofs_off_t maxsize =3D min_t(erofs_off_t, vi.i_size - offse=
t, EROFS_BLKSIZ);<br>
+=C2=A0 =C2=A0 const struct erofs_dirent* de =3D (const struct erofs_dirent=
*)(buf);<br>
+=C2=A0 =C2=A0 struct erofs_dirent* end;<br>
+=C2=A0 =C2=A0 unsigned int nameoff;<br>
+=C2=A0 =C2=A0 err =3D erofs_pread(&amp;vi, buf, maxsize, offset);<br>
+=C2=A0 =C2=A0 if (err)<br>
+=C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 nameoff =3D le16_to_cpu(de-&gt;nameoff);<br>
+=C2=A0 =C2=A0 end =3D (struct erofs_dirent*)(buf + nameoff);<br>
+=C2=A0 =C2=A0 while (de &lt; end) {<br>
+=C2=A0 =C2=A0 =C2=A0 const char* dname;<br>
+=C2=A0 =C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 /* skip &quot;.&quot; and &quot;..&quot; dentry */<br=
>
+=C2=A0 =C2=A0 =C2=A0 if (de-&gt;nid =3D=3D nid || de-&gt;nid =3D=3D parent=
_nid) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 de++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 dname =3D (char*)buf + nameoff;<br>
+=C2=A0 =C2=A0 =C2=A0 ret =3D erofs_checkdirent(de, end, maxsize, dname);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 ret =3D erofs_read_dirent(sbi, de, nid, parent_nid, d=
name, cb, arg);<br>
+=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 ++de;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 offset +=3D maxsize;<br>
+=C2=A0 }<br>
+=C2=A0 return 0;<br>
+}<br>
+<br>
+int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size) =
{<br>
+=C2=A0 *size =3D 0;<br>
+=C2=A0 switch (inode-&gt;datalayout) {<br>
+=C2=A0 =C2=A0 case EROFS_INODE_FLAT_INLINE:<br>
+=C2=A0 =C2=A0 case EROFS_INODE_FLAT_PLAIN:<br>
+=C2=A0 =C2=A0 case EROFS_INODE_CHUNK_BASED:<br>
+=C2=A0 =C2=A0 =C2=A0 *size =3D inode-&gt;i_size;<br>
+=C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case EROFS_INODE_FLAT_COMPRESSION_LEGACY:<br>
+=C2=A0 =C2=A0 case EROFS_INODE_FLAT_COMPRESSION:<br>
+=C2=A0 =C2=A0 =C2=A0 *size =3D inode-&gt;u.i_blocks * EROFS_BLKSIZ;<br>
+=C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 erofs_err(&quot;unknown datalayout&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 }<br>
+=C2=A0 return 0;<br>
+}<br>
+<br>
+int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ErofsIterCallback cb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 void* arg) {<br>
+=C2=A0 return erofs_iterate_dir(sbi, sbi-&gt;root_nid, sbi-&gt;root_nid, c=
b, arg);<br>
+}<br>
+<br>
-- <br>
2.34.1.173.g76aa8bc2d0-goog<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<div><br></div><div>K=
elvin Zhang</div></div></div>

--000000000000ac5c0805d30ec99e--
