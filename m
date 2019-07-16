Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3146AF66
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 20:58:15 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p8mh5wP1zDqfY
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 04:58:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::b44; helo=mail-yb1-xb44.google.com;
 envelope-from=karen.palacio.1994@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iRJAPgW/"; 
 dkim-atps=neutral
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45p8l656P5zDqcw
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 04:56:50 +1000 (AEST)
Received: by mail-yb1-xb44.google.com with SMTP id i1so908025ybo.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kOsu9J0VTfxo4xMD8Uh/SCnU2r/Mf5V670GlkmTJh9w=;
 b=iRJAPgW/SWUolVkD5AdIcvHKElbwn29C+KWnMlDVtXEMmTj7kkrC4Pq0Zd0omd9awH
 koVULW/KzfGJ2IJ2GMJ2BQhin9WTvxJmZU90Zz4uFl77RUu+hrf/+aIvVcgAJ1snJByQ
 Fk6rYr9wEsY99hc4DWHYLIblDYLpL/oWs9FKuy36L9IXpCeitRtG3/+/iBao95U2lMiV
 08GUZseOSmpmdyrbRR8n05R+tYVAZvO4bYfdYR94Z3NFAm2qQCwtUZTTaU99knTTNiOg
 vI9XE7maMhvwnZsc2kQM2doDVe9nqeiUfDD9c09Yv8nQneFqM2Pqs+vuibRrPQQfS33k
 lIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kOsu9J0VTfxo4xMD8Uh/SCnU2r/Mf5V670GlkmTJh9w=;
 b=lIjhKr/AnmDX0GqleHa04Qx1DqGJzfi6HrnbdN6OvNZ9+ECYCXT9xYWN0/Bqr5qWBT
 eMK8XOpwMmki9f3tipG7qUIoTuYFBl0ZTq7QYv1liZPwp9fn/b4P4KQUE1Cum9+u0exo
 cFpaE8Ze+Nou9CMdkHK5URXkpTERTA3NYGSUQNRko5exaTeiXD15AJIUgjwDiDtX2tFx
 ACqCFw+h3cJtGxiXda8kNFl+s95iUKOaPVT/fEhkrjDho0BCZ4ZEHMJ3oNskL/OuiTVY
 5N1PReyPJblRrvq58BL8iKe+PAQjKYwfAqDlgTJg6nuHdUiMvt5EZToRVtxpylou8E3Q
 H+iQ==
X-Gm-Message-State: APjAAAV2gXZXUqQVYGeNbmNi1JSxjSaXGxUrcSSoiG1F4eJryEpvmywi
 EYNdjR5EtOGDj/IISSloMTjN4fcBq52aVU69bJ8=
X-Google-Smtp-Source: APXvYqwEGvvc08Wsc21Rt3R8+i2BtwG3TzIXRwueHsXazW0TU9mi01rAYwACAuPwtxVQZFI5W69wq90QGGaZE28qxVA=
X-Received: by 2002:a25:d289:: with SMTP id j131mr21770124ybg.91.1563303406680; 
 Tue, 16 Jul 2019 11:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <1563294942-31395-1-git-send-email-karen.palacio.1994@gmail.com>
 <1a0b5e37-a5a1-7a2f-0185-860a4aab4b2b@aol.com>
In-Reply-To: <1a0b5e37-a5a1-7a2f-0185-860a4aab4b2b@aol.com>
From: Karen Palacio <karen.palacio.1994@gmail.com>
Date: Tue, 16 Jul 2019 15:56:35 -0300
Message-ID: <CALQQ+Lk9bL2Zs72u30Xe_1p=0389SvOpPMkLfzGHVSenbszfCA@mail.gmail.com>
Subject: Re: [PATCH] staging: erofs: a few minor style fixes found using
 checkpatch
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="0000000000003b3cdf058dd0f04d"
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 gregkh@linuxfoundation.org, yucha0@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000003b3cdf058dd0f04d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, thanks for the fast reply.


*>NACK, all linux filesystems use Opt_xxx. EROFS should obey this practice.=
*I
wasn't aware of that convention, my apologies.

Should I fix that, keep the other changes and resend as v2, or
are you not interested in style patches? I'm interested in contributing to
this
driver, but as I get familiar with it I was planning on making it pass
checkpatch as much as possible.

Thanks,
Karen Palacio.

El mar., 16 jul. 2019 a las 14:03, Gao Xiang (<hsiangkao@aol.com>) escribi=
=C3=B3:

>
>
> On 2019/7/17 ????12:35, Karen Palacio wrote:
> > Fix camel case use in variable names,
> > Fix multiple assignments done in a single line,
> > Fix end of line containing '('.
>
> One type one patch...
>
> >
> > Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> > ---
> >  drivers/staging/erofs/super.c | 55
> ++++++++++++++++++++++---------------------
> >  1 file changed, 28 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/staging/erofs/super.c
> b/drivers/staging/erofs/super.c
> > index 5449441..e281125 100644
> > --- a/drivers/staging/erofs/super.c
> > +++ b/drivers/staging/erofs/super.c
> > @@ -228,21 +228,21 @@ static void default_options(struct erofs_sb_info
> *sbi)
> >  }
> >
> >  enum {
> > -     Opt_user_xattr,
> > -     Opt_nouser_xattr,
> > -     Opt_acl,
> > -     Opt_noacl,
> > -     Opt_fault_injection,
> > -     Opt_err
> > +     opt_user_xattr,
> > +     opt_nouser_xattr,
> > +     opt_acl,
> > +     opt_noacl,
> > +     opt_fault_injection,
> > +     opt_err
>
> NACK, all linux filesystems use Opt_xxx. EROFS should obey this practice.
>
> fs/ext4/super.c
> 1436 enum {
> 1437         Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
> 1438         Opt_resgid, Opt_resuid, Opt_sb, Opt_err_cont,
> Opt_err_panic, Opt_err_ro,
> 1439         Opt_nouid32, Opt_debug, Opt_removed,
> 1440         Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
> 1441         Opt_auto_da_alloc, Opt_noauto_da_alloc, Opt_noload,
> 1442         Opt_commit, Opt_min_batch_time, Opt_max_batch_time,
> Opt_journal_dev,
> 1443         Opt_journal_path, Opt_journal_checksum,
> Opt_journal_async_commit,
> 1444         Opt_abort, Opt_data_journal, Opt_data_ordered,
> Opt_data_writeback,
> 1445         Opt_data_err_abort, Opt_data_err_ignore,
> Opt_test_dummy_encryption,
> 1446         Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota,
> Opt_offgrpjquota,
> 1447         Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quot=
a,
>
> fs/btrfs/super.c
>  294 enum {
>  295         Opt_acl, Opt_noacl,
>  296         Opt_clear_cache,
>  297         Opt_commit_interval,
>  298         Opt_compress,
>  299         Opt_compress_force,
>  300         Opt_compress_force_type,
>  301         Opt_compress_type,
>  302         Opt_degraded,
>  303         Opt_device,
>  304         Opt_fatal_errors,
>
> Thanks,
> Gao Xiang
>
>
> >  };
> >
> >  static match_table_t erofs_tokens =3D {
> > -     {Opt_user_xattr, "user_xattr"},
> > -     {Opt_nouser_xattr, "nouser_xattr"},
> > -     {Opt_acl, "acl"},
> > -     {Opt_noacl, "noacl"},
> > -     {Opt_fault_injection, "fault_injection=3D%u"},
> > -     {Opt_err, NULL}
> > +     {opt_user_xattr, "user_xattr"},
> > +     {opt_nouser_xattr, "nouser_xattr"},
> > +     {opt_acl, "acl"},
> > +     {opt_noacl, "noacl"},
> > +     {opt_fault_injection, "fault_injection=3D%u"},
> > +     {opt_err, NULL}
> >  };
> >
> >  static int parse_options(struct super_block *sb, char *options)
> > @@ -260,41 +260,42 @@ static int parse_options(struct super_block *sb,
> char *options)
> >               if (!*p)
> >                       continue;
> >
> > -             args[0].to =3D args[0].from =3D NULL;
> > +             args[0].to =3D NULL;
> > +             args[0].from =3D NULL;
> >               token =3D match_token(p, erofs_tokens, args);
> >
> >               switch (token) {
> >  #ifdef CONFIG_EROFS_FS_XATTR
> > -             case Opt_user_xattr:
> > +             case opt_user_xattr:
> >                       set_opt(EROFS_SB(sb), XATTR_USER);
> >                       break;
> > -             case Opt_nouser_xattr:
> > +             case opt_nouser_xattr:
> >                       clear_opt(EROFS_SB(sb), XATTR_USER);
> >                       break;
> >  #else
> > -             case Opt_user_xattr:
> > +             case opt_user_xattr:
> >                       infoln("user_xattr options not supported");
> >                       break;
> > -             case Opt_nouser_xattr:
> > +             case opt_nouser_xattr:
> >                       infoln("nouser_xattr options not supported");
> >                       break;
> >  #endif
> >  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> > -             case Opt_acl:
> > +             case opt_acl:
> >                       set_opt(EROFS_SB(sb), POSIX_ACL);
> >                       break;
> > -             case Opt_noacl:
> > +             case opt_noacl:
> >                       clear_opt(EROFS_SB(sb), POSIX_ACL);
> >                       break;
> >  #else
> > -             case Opt_acl:
> > +             case opt_acl:
> >                       infoln("acl options not supported");
> >                       break;
> > -             case Opt_noacl:
> > +             case opt_noacl:
> >                       infoln("noacl options not supported");
> >                       break;
> >  #endif
> > -             case Opt_fault_injection:
> > +             case opt_fault_injection:
> >                       err =3D erofs_build_fault_attr(EROFS_SB(sb), args=
);
> >                       if (err)
> >                               return err;
> > @@ -525,7 +526,6 @@ static void erofs_put_super(struct super_block *sb)
> >       sb->s_fs_info =3D NULL;
> >  }
> >
> > -
> >  struct erofs_mount_private {
> >       const char *dev_name;
> >       char *options;
> > @@ -541,9 +541,9 @@ static int erofs_fill_super(struct super_block *sb,
> >               priv->options, silent);
> >  }
> >
> > -static struct dentry *erofs_mount(
> > -     struct file_system_type *fs_type, int flags,
> > -     const char *dev_name, void *data)
> > +static struct dentry *erofs_mount(struct file_system_type *fs_type,
> > +                               int flags,
> > +                               const char *dev_name, void *data)
> >  {
> >       struct erofs_mount_private priv =3D {
> >               .dev_name =3D dev_name,
> > @@ -623,7 +623,8 @@ static int erofs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
> >       buf->f_type =3D sb->s_magic;
> >       buf->f_bsize =3D EROFS_BLKSIZ;
> >       buf->f_blocks =3D sbi->blocks;
> > -     buf->f_bfree =3D buf->f_bavail =3D 0;
> > +     buf->f_bfree =3D 0;
> > +     buf->f_bavail =3D 0;
> >
> >       buf->f_files =3D ULLONG_MAX;
> >       buf->f_ffree =3D ULLONG_MAX - sbi->inos;
> >
>

--0000000000003b3cdf058dd0f04d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello, thanks for the fast reply.=C2=A0<div><br><i>&gt;NAC=
K, all linux filesystems use Opt_xxx. EROFS should obey this practice.<br><=
/i>I wasn&#39;t aware of that convention, my apologies.</div><div><br>Shoul=
d I fix that, keep the other changes and resend as v2, or <br>are you not i=
nterested in style patches? I&#39;m interested in contributing to this<br>d=
river, but as I get familiar with it I was planning on making it pass<br>ch=
eckpatch as much as possible.<br><br>Thanks,<br>Karen Palacio.</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">El mar.=
, 16 jul. 2019 a las 14:03, Gao Xiang (&lt;<a href=3D"mailto:hsiangkao@aol.=
com">hsiangkao@aol.com</a>&gt;) escribi=C3=B3:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
<br>
On 2019/7/17 ????12:35, Karen Palacio wrote:<br>
&gt; Fix camel case use in variable names,<br>
&gt; Fix multiple assignments done in a single line,<br>
&gt; Fix end of line containing &#39;(&#39;.<br>
<br>
One type one patch...<br>
<br>
&gt; <br>
&gt; Signed-off-by: Karen Palacio &lt;<a href=3D"mailto:karen.palacio.1994@=
gmail.com" target=3D"_blank">karen.palacio.1994@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/erofs/super.c | 55 ++++++++++++++++++++++-------=
--------------<br>
&gt;=C2=A0 1 file changed, 28 insertions(+), 27 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/sup=
er.c<br>
&gt; index 5449441..e281125 100644<br>
&gt; --- a/drivers/staging/erofs/super.c<br>
&gt; +++ b/drivers/staging/erofs/super.c<br>
&gt; @@ -228,21 +228,21 @@ static void default_options(struct erofs_sb_info=
 *sbi)<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 enum {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0Opt_user_xattr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0Opt_nouser_xattr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0Opt_acl,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0Opt_noacl,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0Opt_fault_injection,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0Opt_err<br>
&gt; +=C2=A0 =C2=A0 =C2=A0opt_user_xattr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0opt_nouser_xattr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0opt_acl,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0opt_noacl,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0opt_fault_injection,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0opt_err<br>
<br>
NACK, all linux filesystems use Opt_xxx. EROFS should obey this practice.<b=
r>
<br>
fs/ext4/super.c<br>
1436 enum {<br>
1437=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_bsd_df, Opt_minix_df, Opt_grpid, =
Opt_nogrpid,<br>
1438=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_resgid, Opt_resuid, Opt_sb, Opt_e=
rr_cont,<br>
Opt_err_panic, Opt_err_ro,<br>
1439=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_nouid32, Opt_debug, Opt_removed,<=
br>
1440=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_user_xattr, Opt_nouser_xattr, Opt=
_acl, Opt_noacl,<br>
1441=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_auto_da_alloc, Opt_noauto_da_allo=
c, Opt_noload,<br>
1442=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_commit, Opt_min_batch_time, Opt_m=
ax_batch_time,<br>
Opt_journal_dev,<br>
1443=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_journal_path, Opt_journal_checksu=
m,<br>
Opt_journal_async_commit,<br>
1444=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_abort, Opt_data_journal, Opt_data=
_ordered,<br>
Opt_data_writeback,<br>
1445=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_data_err_abort, Opt_data_err_igno=
re,<br>
Opt_test_dummy_encryption,<br>
1446=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_usrjquota, Opt_grpjquota, Opt_off=
usrjquota,<br>
Opt_offgrpjquota,<br>
1447=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Op=
t_jqfmt_vfsv1, Opt_quota,<br>
<br>
fs/btrfs/super.c<br>
=C2=A0294 enum {<br>
=C2=A0295=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_acl, Opt_noacl,<br>
=C2=A0296=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_clear_cache,<br>
=C2=A0297=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_commit_interval,<br>
=C2=A0298=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_compress,<br>
=C2=A0299=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_compress_force,<br>
=C2=A0300=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_compress_force_type,<br>
=C2=A0301=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_compress_type,<br>
=C2=A0302=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_degraded,<br>
=C2=A0303=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_device,<br>
=C2=A0304=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Opt_fatal_errors,<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static match_table_t erofs_tokens =3D {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{Opt_user_xattr, &quot;user_xattr&quot;},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{Opt_nouser_xattr, &quot;nouser_xattr&quot;},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{Opt_acl, &quot;acl&quot;},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{Opt_noacl, &quot;noacl&quot;},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{Opt_fault_injection, &quot;fault_injection=3D%u&=
quot;},<br>
&gt; -=C2=A0 =C2=A0 =C2=A0{Opt_err, NULL}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{opt_user_xattr, &quot;user_xattr&quot;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{opt_nouser_xattr, &quot;nouser_xattr&quot;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{opt_acl, &quot;acl&quot;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{opt_noacl, &quot;noacl&quot;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{opt_fault_injection, &quot;fault_injection=3D%u&=
quot;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{opt_err, NULL}<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int parse_options(struct super_block *sb, char *options)<=
br>
&gt; @@ -260,41 +260,42 @@ static int parse_options(struct super_block *sb,=
 char *options)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*p)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args[0].to =3D args[0=
].from =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args[0].to =3D NULL;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args[0].from =3D NULL=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0token =3D match_=
token(p, erofs_tokens, args);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (token) {=
<br>
&gt;=C2=A0 #ifdef CONFIG_EROFS_FS_XATTR<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_user_xattr:<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_user_xattr:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0set_opt(EROFS_SB(sb), XATTR_USER);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_nouser_xattr=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_nouser_xattr=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0clear_opt(EROFS_SB(sb), XATTR_USER);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 #else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_user_xattr:<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_user_xattr:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0infoln(&quot;user_xattr options not supported&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_nouser_xattr=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_nouser_xattr=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0infoln(&quot;nouser_xattr options not supported&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 #ifdef CONFIG_EROFS_FS_POSIX_ACL<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_acl:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_acl:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0set_opt(EROFS_SB(sb), POSIX_ACL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_noacl:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_noacl:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0clear_opt(EROFS_SB(sb), POSIX_ACL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 #else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_acl:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_acl:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0infoln(&quot;acl options not supported&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_noacl:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_noacl:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0infoln(&quot;noacl options not supported&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 #endif<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case Opt_fault_inject=
ion:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case opt_fault_inject=
ion:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0err =3D erofs_build_fault_attr(EROFS_SB(sb), args);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (err)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; @@ -525,7 +526,6 @@ static void erofs_put_super(struct super_block *sb=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb-&gt;s_fs_info =3D NULL;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt;=C2=A0 struct erofs_mount_private {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *dev_name;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *options;<br>
&gt; @@ -541,9 +541,9 @@ static int erofs_fill_super(struct super_block *sb=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv-&gt;options=
, silent);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static struct dentry *erofs_mount(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct file_system_type *fs_type, int flags,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0const char *dev_name, void *data)<br>
&gt; +static struct dentry *erofs_mount(struct file_system_type *fs_type,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *dev_name, void *data)=
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_mount_private priv =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev_name =3D de=
v_name,<br>
&gt; @@ -623,7 +623,8 @@ static int erofs_statfs(struct dentry *dentry, str=
uct kstatfs *buf)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf-&gt;f_type =3D sb-&gt;s_magic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf-&gt;f_bsize =3D EROFS_BLKSIZ;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf-&gt;f_blocks =3D sbi-&gt;blocks;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0buf-&gt;f_bfree =3D buf-&gt;f_bavail =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf-&gt;f_bfree =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf-&gt;f_bavail =3D 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf-&gt;f_files =3D ULLONG_MAX;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf-&gt;f_ffree =3D ULLONG_MAX - sbi-&gt;ino=
s;<br>
&gt; <br>
</blockquote></div>

--0000000000003b3cdf058dd0f04d--
