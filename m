Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F141911333
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 22:30:21 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FGEgwD8W;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4sYk1pN0z3cY9
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 06:30:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FGEgwD8W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=smfrench@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4sYc1Hbjz3cTc
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 06:30:11 +1000 (AEST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ec1e5505abso19306541fa.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2024 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718915408; x=1719520208; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0AaZXz6HCbDa8eUXXe1u+dAsA44D+SEYRxa0tXuHTh0=;
        b=FGEgwD8WirUfo9lV/t88k5aF7sObDohKD1gTPckQLnZtEN7H7nfcl/AZy1K/pHaepd
         w0mAHh4KFVJlVxGdu6mXpy3LBJkB927c5qZORqYNcPRt5HOB3C8dwoft+QgYZlXv6olw
         daNzSn+CbM4t6Z1UXV6z4nBXYRzpTHjZqLRu1eo4S+3hfgMwMMHtiCQ1swGM4/jIncZG
         hvyFB9Cko5d4Vq9jJx/HW3mLX3t1Z0sj8CdRsl/m3268n4EnKtulKbWcu0tM1Yfzk109
         GClJQEsO3UNQeWUceINHHT8cB4O+xcehsBSpPtQfI62aPHVBfYV1VVlwPc75aZYlMdra
         8AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915408; x=1719520208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AaZXz6HCbDa8eUXXe1u+dAsA44D+SEYRxa0tXuHTh0=;
        b=lXXGQMe4I9vZHEtJbKJzfTJRBh6f+mHjA8asLwgXYqlgpis+BVOL9C/39lAv4G4UsW
         q4XyMnnjuFCQfn+PHNXqTu/L/iSq9kce+GxQK8JfevpTo/ekpDkoCIAzg2DcqY/lPcJH
         ikEl1ugdgMTwIQvEEfEVpJR/Bsv2hgDLegQCqL2lyHjhpnjfwK4XWwq6QvpSMK7Y02eU
         bXUnW8qITxNN6nMYVrAYaGsjd5xtIaORy95P05JSMTqWcc92jtfTv1dpNkXvyr/I6UoZ
         FPFU5DQ1SttUnOlSopDOJsuRlwhueFtzwp67xfMml05dGflyXApztEq/xhN6+vNv2QP9
         0VNA==
X-Forwarded-Encrypted: i=1; AJvYcCXXaGANcLr6b8AeCrF/vWJg/EuFs1+8Xqbgrewh+7Gv22xGjArHZJrOza8YJ/kczI+ZXCWiYkJtcy6llJTePsH3W5Es8uKMUIOz5O/f
X-Gm-Message-State: AOJu0Yw5y4jHsWruJ5Adzbu+QkrCfHDplnnUkZQA6bwp7Y9RFZepKZng
	fGHnkRt+AY/z7eDOAW1Z5WEbdAek53eP0M3WcBoVRy28cRznvtgMs6uzr2XYahqz0UptpDrqqWx
	Cr7uIrvqPwy/Ui+ZLp0scdJ1s6G0=
X-Google-Smtp-Source: AGHT+IFk6q/dXNhXYXDhrUm+mDzeMQfdZv7VZ9OPGc51XKug052EHkQ3ljAMDvpoF6rjKSriSIZLOgYF8z96ER7Fo8Q=
X-Received: by 2002:a05:651c:2006:b0:2ec:35a3:20bd with SMTP id
 38308e7fff4ca-2ec35a321eemr24171601fa.22.1718915407469; Thu, 20 Jun 2024
 13:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240620173137.610345-1-dhowells@redhat.com> <20240620173137.610345-12-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-12-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 20 Jun 2024 15:29:55 -0500
Message-ID: <CAH2r5mv_C3qKsaweAriY40D-KJzs9+8J6TFcs1oeTUKA+t__vw@mail.gmail.com>
Subject: Re: [PATCH 11/17] cifs: Move the 'pid' from the subreq to the req
To: David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000004305c8061b582e10"
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000004305c8061b582e10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

minor update to the patch. Fix function =E2=80=98cifs_req_issue_read=E2=80=
=99 to
remove the warning:
/home/smfrench/cifs-2.6/fs/smb/client/file.c:180:30: warning: unused
variable =E2=80=98cifs_sb
See attached.

Merged this and two more from the series tentatively into cifs-2.6.git
for-next pending more testing/review

969b3010cbfc cifs: Only pick a channel once per read request
ce5291e56081 cifs: Defer read completion

On Thu, Jun 20, 2024 at 12:33=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Move the reference pid from the cifs_io_subrequest struct to the
> cifs_io_request struct as it's the same for all subreqs of a particular
> request.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifsglob.h |  2 +-
>  fs/smb/client/cifssmb.c  |  8 ++++----
>  fs/smb/client/file.c     | 10 +++-------
>  fs/smb/client/smb2pdu.c  |  4 ++--
>  4 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index b48d3f5e8889..bbcc552c07be 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -1495,6 +1495,7 @@ struct cifs_io_request {
>         struct netfs_io_request         rreq;
>         struct cifsFileInfo             *cfile;
>         struct TCP_Server_Info          *server;
> +       pid_t                           pid;
>  };
>
>  /* asynchronous read support */
> @@ -1505,7 +1506,6 @@ struct cifs_io_subrequest {
>                 struct cifs_io_request *req;
>         };
>         ssize_t                         got_bytes;
> -       pid_t                           pid;
>         unsigned int                    xid;
>         int                             result;
>         bool                            have_xid;
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 25e9ab947c17..595c4b673707 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -1345,8 +1345,8 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
>         if (rc)
>                 return rc;
>
> -       smb->hdr.Pid =3D cpu_to_le16((__u16)rdata->pid);
> -       smb->hdr.PidHigh =3D cpu_to_le16((__u16)(rdata->pid >> 16));
> +       smb->hdr.Pid =3D cpu_to_le16((__u16)rdata->req->pid);
> +       smb->hdr.PidHigh =3D cpu_to_le16((__u16)(rdata->req->pid >> 16));
>
>         smb->AndXCommand =3D 0xFF;        /* none */
>         smb->Fid =3D rdata->req->cfile->fid.netfid;
> @@ -1689,8 +1689,8 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
>         if (rc)
>                 goto async_writev_out;
>
> -       smb->hdr.Pid =3D cpu_to_le16((__u16)wdata->pid);
> -       smb->hdr.PidHigh =3D cpu_to_le16((__u16)(wdata->pid >> 16));
> +       smb->hdr.Pid =3D cpu_to_le16((__u16)wdata->req->pid);
> +       smb->hdr.PidHigh =3D cpu_to_le16((__u16)(wdata->req->pid >> 16));
>
>         smb->AndXCommand =3D 0xFF;        /* none */
>         smb->Fid =3D wdata->req->cfile->fid.netfid;
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 16fa1ac1ed2d..45c860f0e7fd 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -178,14 +178,8 @@ static void cifs_req_issue_read(struct netfs_io_subr=
equest *subreq)
>         struct cifs_io_subrequest *rdata =3D container_of(subreq, struct =
cifs_io_subrequest, subreq);
>         struct cifs_io_request *req =3D container_of(subreq->rreq, struct=
 cifs_io_request, rreq);
>         struct cifs_sb_info *cifs_sb =3D CIFS_SB(rreq->inode->i_sb);
> -       pid_t pid;
>         int rc =3D 0;
>
> -       if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
> -               pid =3D req->cfile->pid;
> -       else
> -               pid =3D current->tgid; // Ummm...  This may be a workqueu=
e
> -
>         cifs_dbg(FYI, "%s: op=3D%08x[%x] mapping=3D%p len=3D%zu/%zu\n",
>                  __func__, rreq->debug_id, subreq->debug_index, rreq->map=
ping,
>                  subreq->transferred, subreq->len);
> @@ -199,7 +193,6 @@ static void cifs_req_issue_read(struct netfs_io_subre=
quest *subreq)
>         }
>
>         __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> -       rdata->pid =3D pid;
>
>         rc =3D rdata->server->ops->async_readv(rdata);
>  out:
> @@ -236,12 +229,15 @@ static int cifs_init_request(struct netfs_io_reques=
t *rreq, struct file *file)
>
>         rreq->rsize =3D cifs_sb->ctx->rsize;
>         rreq->wsize =3D cifs_sb->ctx->wsize;
> +       req->pid =3D current->tgid; // Ummm...  This may be a workqueue
>
>         if (file) {
>                 open_file =3D file->private_data;
>                 rreq->netfs_priv =3D file->private_data;
>                 req->cfile =3D cifsFileInfo_get(open_file);
>                 req->server =3D cifs_pick_channel(tlink_tcon(req->cfile->=
tlink)->ses);
> +               if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
> +                       req->pid =3D req->cfile->pid;
>         } else if (rreq->origin !=3D NETFS_WRITEBACK) {
>                 WARN_ON_ONCE(1);
>                 return -EIO;
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index e213cecd5094..2ae2dbb6202b 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -4621,7 +4621,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
>         io_parms.length =3D rdata->subreq.len;
>         io_parms.persistent_fid =3D rdata->req->cfile->fid.persistent_fid=
;
>         io_parms.volatile_fid =3D rdata->req->cfile->fid.volatile_fid;
> -       io_parms.pid =3D rdata->pid;
> +       io_parms.pid =3D rdata->req->pid;
>
>         rc =3D smb2_new_read_req(
>                 (void **) &buf, &total_len, &io_parms, rdata, 0, 0);
> @@ -4873,7 +4873,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
>                 .length =3D wdata->subreq.len,
>                 .persistent_fid =3D wdata->req->cfile->fid.persistent_fid=
,
>                 .volatile_fid =3D wdata->req->cfile->fid.volatile_fid,
> -               .pid =3D wdata->pid,
> +               .pid =3D wdata->req->pid,
>         };
>         io_parms =3D &_io_parms;
>
>


--=20
Thanks,

Steve

--0000000000004305c8061b582e10
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-Move-the-pid-from-the-subreq-to-the-req.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-Move-the-pid-from-the-subreq-to-the-req.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxnpuc0k0>
X-Attachment-Id: f_lxnpuc0k0

RnJvbSAzZjU5MTM4NTgwYmY4MDA2ZmE5OTY0MWI1ODAzZDBmNjgzNzA5ZjEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUaHUsIDIwIEp1biAyMDI0IDE4OjMxOjI5ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gY2lm
czogTW92ZSB0aGUgJ3BpZCcgZnJvbSB0aGUgc3VicmVxIHRvIHRoZSByZXEKCk1vdmUgdGhlIHJl
ZmVyZW5jZSBwaWQgZnJvbSB0aGUgY2lmc19pb19zdWJyZXF1ZXN0IHN0cnVjdCB0byB0aGUKY2lm
c19pb19yZXF1ZXN0IHN0cnVjdCBhcyBpdCdzIHRoZSBzYW1lIGZvciBhbGwgc3VicmVxcyBvZiBh
IHBhcnRpY3VsYXIKcmVxdWVzdC4KClNpZ25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dl
bGxzQHJlZGhhdC5jb20+CmNjOiBQYXVsbyBBbGNhbnRhcmEgPHBjQG1hbmd1ZWJpdC5jb20+CmNj
OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPgpjYzogbGludXgtY2lmc0B2Z2VyLmtl
cm5lbC5vcmcKY2M6IG5ldGZzQGxpc3RzLmxpbnV4LmRldgpjYzogbGludXgtZnNkZXZlbEB2Z2Vy
Lmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3Nv
ZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaCB8ICAyICstCiBmcy9zbWIvY2xp
ZW50L2NpZnNzbWIuYyAgfCAgOCArKysrLS0tLQogZnMvc21iL2NsaWVudC9maWxlLmMgICAgIHwg
MTEgKysrLS0tLS0tLS0KIGZzL3NtYi9jbGllbnQvc21iMnBkdS5jICB8ICA0ICsrLS0KIDQgZmls
ZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oIGIvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oCmlu
ZGV4IDA5Nzg5OTdkZGZhNi4uNTU3YjY4ZTk5ZDBhIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50
L2NpZnNnbG9iLmgKKysrIGIvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oCkBAIC0xNDk1LDYgKzE0
OTUsNyBAQCBzdHJ1Y3QgY2lmc19pb19yZXF1ZXN0IHsKIAlzdHJ1Y3QgbmV0ZnNfaW9fcmVxdWVz
dAkJcnJlcTsKIAlzdHJ1Y3QgY2lmc0ZpbGVJbmZvCQkqY2ZpbGU7CiAJc3RydWN0IFRDUF9TZXJ2
ZXJfSW5mbwkJKnNlcnZlcjsKKwlwaWRfdAkJCQlwaWQ7CiB9OwogCiAvKiBhc3luY2hyb25vdXMg
cmVhZCBzdXBwb3J0ICovCkBAIC0xNTA1LDcgKzE1MDYsNiBAQCBzdHJ1Y3QgY2lmc19pb19zdWJy
ZXF1ZXN0IHsKIAkJc3RydWN0IGNpZnNfaW9fcmVxdWVzdCAqcmVxOwogCX07CiAJc3NpemVfdAkJ
CQlnb3RfYnl0ZXM7Ci0JcGlkX3QJCQkJcGlkOwogCXVuc2lnbmVkIGludAkJCXhpZDsKIAlpbnQJ
CQkJcmVzdWx0OwogCWJvb2wJCQkJaGF2ZV94aWQ7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50
L2NpZnNzbWIuYyBiL2ZzL3NtYi9jbGllbnQvY2lmc3NtYi5jCmluZGV4IDI1ZTlhYjk0N2MxNy4u
NTk1YzRiNjczNzA3IDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2NpZnNzbWIuYworKysgYi9m
cy9zbWIvY2xpZW50L2NpZnNzbWIuYwpAQCAtMTM0NSw4ICsxMzQ1LDggQEAgY2lmc19hc3luY19y
ZWFkdihzdHJ1Y3QgY2lmc19pb19zdWJyZXF1ZXN0ICpyZGF0YSkKIAlpZiAocmMpCiAJCXJldHVy
biByYzsKIAotCXNtYi0+aGRyLlBpZCA9IGNwdV90b19sZTE2KChfX3UxNilyZGF0YS0+cGlkKTsK
LQlzbWItPmhkci5QaWRIaWdoID0gY3B1X3RvX2xlMTYoKF9fdTE2KShyZGF0YS0+cGlkID4+IDE2
KSk7CisJc21iLT5oZHIuUGlkID0gY3B1X3RvX2xlMTYoKF9fdTE2KXJkYXRhLT5yZXEtPnBpZCk7
CisJc21iLT5oZHIuUGlkSGlnaCA9IGNwdV90b19sZTE2KChfX3UxNikocmRhdGEtPnJlcS0+cGlk
ID4+IDE2KSk7CiAKIAlzbWItPkFuZFhDb21tYW5kID0gMHhGRjsJLyogbm9uZSAqLwogCXNtYi0+
RmlkID0gcmRhdGEtPnJlcS0+Y2ZpbGUtPmZpZC5uZXRmaWQ7CkBAIC0xNjg5LDggKzE2ODksOCBA
QCBjaWZzX2FzeW5jX3dyaXRldihzdHJ1Y3QgY2lmc19pb19zdWJyZXF1ZXN0ICp3ZGF0YSkKIAlp
ZiAocmMpCiAJCWdvdG8gYXN5bmNfd3JpdGV2X291dDsKIAotCXNtYi0+aGRyLlBpZCA9IGNwdV90
b19sZTE2KChfX3UxNil3ZGF0YS0+cGlkKTsKLQlzbWItPmhkci5QaWRIaWdoID0gY3B1X3RvX2xl
MTYoKF9fdTE2KSh3ZGF0YS0+cGlkID4+IDE2KSk7CisJc21iLT5oZHIuUGlkID0gY3B1X3RvX2xl
MTYoKF9fdTE2KXdkYXRhLT5yZXEtPnBpZCk7CisJc21iLT5oZHIuUGlkSGlnaCA9IGNwdV90b19s
ZTE2KChfX3UxNikod2RhdGEtPnJlcS0+cGlkID4+IDE2KSk7CiAKIAlzbWItPkFuZFhDb21tYW5k
ID0gMHhGRjsJLyogbm9uZSAqLwogCXNtYi0+RmlkID0gd2RhdGEtPnJlcS0+Y2ZpbGUtPmZpZC5u
ZXRmaWQ7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2ZpbGUuYyBiL2ZzL3NtYi9jbGllbnQv
ZmlsZS5jCmluZGV4IDRkYmQ4MDE2OGEyYi4uZjFmMjU3M2JiMThkIDEwMDY0NAotLS0gYS9mcy9z
bWIvY2xpZW50L2ZpbGUuYworKysgYi9mcy9zbWIvY2xpZW50L2ZpbGUuYwpAQCAtMTc3LDE1ICsx
NzcsOCBAQCBzdGF0aWMgdm9pZCBjaWZzX3JlcV9pc3N1ZV9yZWFkKHN0cnVjdCBuZXRmc19pb19z
dWJyZXF1ZXN0ICpzdWJyZXEpCiAJc3RydWN0IG5ldGZzX2lvX3JlcXVlc3QgKnJyZXEgPSBzdWJy
ZXEtPnJyZXE7CiAJc3RydWN0IGNpZnNfaW9fc3VicmVxdWVzdCAqcmRhdGEgPSBjb250YWluZXJf
b2Yoc3VicmVxLCBzdHJ1Y3QgY2lmc19pb19zdWJyZXF1ZXN0LCBzdWJyZXEpOwogCXN0cnVjdCBj
aWZzX2lvX3JlcXVlc3QgKnJlcSA9IGNvbnRhaW5lcl9vZihzdWJyZXEtPnJyZXEsIHN0cnVjdCBj
aWZzX2lvX3JlcXVlc3QsIHJyZXEpOwotCXN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2IgPSBD
SUZTX1NCKHJyZXEtPmlub2RlLT5pX3NiKTsKLQlwaWRfdCBwaWQ7CiAJaW50IHJjID0gMDsKIAot
CWlmIChjaWZzX3NiLT5tbnRfY2lmc19mbGFncyAmIENJRlNfTU9VTlRfUldQSURGT1JXQVJEKQot
CQlwaWQgPSByZXEtPmNmaWxlLT5waWQ7Ci0JZWxzZQotCQlwaWQgPSBjdXJyZW50LT50Z2lkOyAv
LyBVbW1tLi4uICBUaGlzIG1heSBiZSBhIHdvcmtxdWV1ZQotCiAJY2lmc19kYmcoRllJLCAiJXM6
IG9wPSUwOHhbJXhdIG1hcHBpbmc9JXAgbGVuPSV6dS8lenVcbiIsCiAJCSBfX2Z1bmNfXywgcnJl
cS0+ZGVidWdfaWQsIHN1YnJlcS0+ZGVidWdfaW5kZXgsIHJyZXEtPm1hcHBpbmcsCiAJCSBzdWJy
ZXEtPnRyYW5zZmVycmVkLCBzdWJyZXEtPmxlbik7CkBAIC0xOTksNyArMTkyLDYgQEAgc3RhdGlj
IHZvaWQgY2lmc19yZXFfaXNzdWVfcmVhZChzdHJ1Y3QgbmV0ZnNfaW9fc3VicmVxdWVzdCAqc3Vi
cmVxKQogCX0KIAogCV9fc2V0X2JpdChORVRGU19TUkVRX0NMRUFSX1RBSUwsICZzdWJyZXEtPmZs
YWdzKTsKLQlyZGF0YS0+cGlkID0gcGlkOwogCiAJcmMgPSByZGF0YS0+c2VydmVyLT5vcHMtPmFz
eW5jX3JlYWR2KHJkYXRhKTsKIG91dDoKQEAgLTIzNiwxMiArMjI4LDE1IEBAIHN0YXRpYyBpbnQg
Y2lmc19pbml0X3JlcXVlc3Qoc3RydWN0IG5ldGZzX2lvX3JlcXVlc3QgKnJyZXEsIHN0cnVjdCBm
aWxlICpmaWxlKQogCiAJcnJlcS0+cnNpemUgPSBjaWZzX3NiLT5jdHgtPnJzaXplOwogCXJyZXEt
PndzaXplID0gY2lmc19zYi0+Y3R4LT53c2l6ZTsKKwlyZXEtPnBpZCA9IGN1cnJlbnQtPnRnaWQ7
IC8vIFVtbW0uLi4gIFRoaXMgbWF5IGJlIGEgd29ya3F1ZXVlCiAKIAlpZiAoZmlsZSkgewogCQlv
cGVuX2ZpbGUgPSBmaWxlLT5wcml2YXRlX2RhdGE7CiAJCXJyZXEtPm5ldGZzX3ByaXYgPSBmaWxl
LT5wcml2YXRlX2RhdGE7CiAJCXJlcS0+Y2ZpbGUgPSBjaWZzRmlsZUluZm9fZ2V0KG9wZW5fZmls
ZSk7CiAJCXJlcS0+c2VydmVyID0gY2lmc19waWNrX2NoYW5uZWwodGxpbmtfdGNvbihyZXEtPmNm
aWxlLT50bGluayktPnNlcyk7CisJCWlmIChjaWZzX3NiLT5tbnRfY2lmc19mbGFncyAmIENJRlNf
TU9VTlRfUldQSURGT1JXQVJEKQorCQkJcmVxLT5waWQgPSByZXEtPmNmaWxlLT5waWQ7CiAJfSBl
bHNlIGlmIChycmVxLT5vcmlnaW4gIT0gTkVURlNfV1JJVEVCQUNLKSB7CiAJCVdBUk5fT05fT05D
RSgxKTsKIAkJcmV0dXJuIC1FSU87CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L3NtYjJwZHUu
YyBiL2ZzL3NtYi9jbGllbnQvc21iMnBkdS5jCmluZGV4IGUyMTNjZWNkNTA5NC4uMmFlMmRiYjYy
MDJiIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L3NtYjJwZHUuYworKysgYi9mcy9zbWIvY2xp
ZW50L3NtYjJwZHUuYwpAQCAtNDYyMSw3ICs0NjIxLDcgQEAgc21iMl9hc3luY19yZWFkdihzdHJ1
Y3QgY2lmc19pb19zdWJyZXF1ZXN0ICpyZGF0YSkKIAlpb19wYXJtcy5sZW5ndGggPSByZGF0YS0+
c3VicmVxLmxlbjsKIAlpb19wYXJtcy5wZXJzaXN0ZW50X2ZpZCA9IHJkYXRhLT5yZXEtPmNmaWxl
LT5maWQucGVyc2lzdGVudF9maWQ7CiAJaW9fcGFybXMudm9sYXRpbGVfZmlkID0gcmRhdGEtPnJl
cS0+Y2ZpbGUtPmZpZC52b2xhdGlsZV9maWQ7Ci0JaW9fcGFybXMucGlkID0gcmRhdGEtPnBpZDsK
Kwlpb19wYXJtcy5waWQgPSByZGF0YS0+cmVxLT5waWQ7CiAKIAlyYyA9IHNtYjJfbmV3X3JlYWRf
cmVxKAogCQkodm9pZCAqKikgJmJ1ZiwgJnRvdGFsX2xlbiwgJmlvX3Bhcm1zLCByZGF0YSwgMCwg
MCk7CkBAIC00ODczLDcgKzQ4NzMsNyBAQCBzbWIyX2FzeW5jX3dyaXRldihzdHJ1Y3QgY2lmc19p
b19zdWJyZXF1ZXN0ICp3ZGF0YSkKIAkJLmxlbmd0aCA9IHdkYXRhLT5zdWJyZXEubGVuLAogCQku
cGVyc2lzdGVudF9maWQgPSB3ZGF0YS0+cmVxLT5jZmlsZS0+ZmlkLnBlcnNpc3RlbnRfZmlkLAog
CQkudm9sYXRpbGVfZmlkID0gd2RhdGEtPnJlcS0+Y2ZpbGUtPmZpZC52b2xhdGlsZV9maWQsCi0J
CS5waWQgPSB3ZGF0YS0+cGlkLAorCQkucGlkID0gd2RhdGEtPnJlcS0+cGlkLAogCX07CiAJaW9f
cGFybXMgPSAmX2lvX3Bhcm1zOwogCi0tIAoyLjQzLjAKCg==
--0000000000004305c8061b582e10--
