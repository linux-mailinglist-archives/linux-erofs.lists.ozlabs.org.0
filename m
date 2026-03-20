Return-Path: <linux-erofs+bounces-2882-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCqHMsg+vWmJ8AIAu9opvQ
	(envelope-from <linux-erofs+bounces-2882-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 13:34:16 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 743812DA52A
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 13:34:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fchnw62ttz2yYY;
	Fri, 20 Mar 2026 23:34:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774010052;
	cv=pass; b=WYp0sgqBvEX3peAzEpNRVwS2y1jCzJGp/TLeaEDLA7cLlyxubC+OvUEw8lIslZx3w0t+j8Nw6XDXd32bAs+8gWf01Xn06GXnwaAJ3+rqC3ZpF3iVe2d7sJidIoGaPtX5zbyU3A3qYMK5XzIxhxMDuTVlLWFlQ66XbptiC1nerdHmKs9NHRyq7ptsaj/qnwCTSuunhgSq2derSdklK0tCMJO24uTJeqlDCzx9tmuQw+ARW3OgG4YQaC1nWOOduz3TcQeXE5glk6NF2acCW1FY+4pz8uGxIqbGSCJsEutPDZmDoJLEJt/jBuLv/04zNKw1MT9cFm8oLLtfzB45i6OBKg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774010052; c=relaxed/relaxed;
	bh=3K8SJZxerjn7Jv5y3gL2e2Dax0E0bqqyMdQ4wn7A4ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4GEpew4Q1Qom5gRaJ8EogAg4OY3hDujhCjtIBXFmm3CCWbTozzYF/DwWMgYm6mwOZ8DUDyDoBiZEga9eO3xiVNu1qzZL7QhOWMoQQtSWwipH7aFlJnw4lNHNk/cy7qH7QqDfsDghMCiJr2uvXTBHY2cy9vOmmu/QGRi5CoRnFAUSX0TWlMQfVfBXvk+Fs4tUdHLb47SI1CGeiJTU7HffnmqpdIB/VKscQjbOmRnonLtou5JGw5C0N/Z2ODuiNxVpfjNUy0/P3h06vSYCWPmPwzgg8pJFdRl0xA4Mrb4Lvd+JxErohsoN/mkUsqwQvRG1ttvXxpJtO4ObI6hMhG/ug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TS725zKh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TS725zKh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fchnv57QGz2yY9
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 23:34:11 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-b936331786dso186639666b.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 05:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774010048; cv=none;
        d=google.com; s=arc-20240605;
        b=lgozahQkL7h7ezhTwiH6rQzx4vGqPZ1tX0n/eixX5CLT97MgEuhvNHdnCInYoCLgQ0
         xrRDVwneShClYOMCIrhMj3jiAr/RNboRoZBxu27HHk1+iv/HVdNQyf/tpJk8vN143mSO
         mNF65bTj9xyLqtUO3q4kfsUfA74kiz/ac8FD/KTzoLj4/0TZlUn9/4YlNSB0lZgm3iag
         hmyjYjIun64Z7gCMUgzrjn+LvSlJiSQQ1qhFSBFbcS+w/frfd98za6bePfalLLkuIXMT
         SQuuMpq3/Wyw7zQGB/2MT4Uh5djfLZjeOF6Zd2XRlMpPPE+MZFXGotNVubXfb8FfmtY7
         Y3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3K8SJZxerjn7Jv5y3gL2e2Dax0E0bqqyMdQ4wn7A4ls=;
        fh=KDmI3xyCQhkfBX/4TeVHKsP/yb801jC3Yqc/nrhx78s=;
        b=Ma5/WIFGGgCupapXeGHRAexarCbzUllR7cIZ+KJ+/OYBfbTn5ZrC5jIClYY9cSsgRK
         cXx/owvq21mmPnN+3/HPlkf02N98pSxyxcNGQmOm6HwjxlB3SoeS5XSCEPeDprqk20O3
         xPjnbS4FJqWB77rgGxPD1IrAtEiTZoGXZc8j70wt92dvM84VHskrYInt3we5HgKUh+A/
         Ntrg8ADg4LZj5lv+umGAdWI8RaiE71F4wvGPsm2loVAb2fa+S6G1r72lObG2M7svpXYH
         vAbLBkztvPjPALzQ2zdax47rJwGCete8W7GUkUjjJ8c2FD2Dmi0hd7Rs6aUcpmV4d1jg
         3DPg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774010048; x=1774614848; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K8SJZxerjn7Jv5y3gL2e2Dax0E0bqqyMdQ4wn7A4ls=;
        b=TS725zKhX7fRBlsBHAZlIwzx+EELHUJzQVEav5sdnbJ1zb66arw0alJLCndvU8U+Cf
         TuNC6jfOJIw8Y294EV/9EjpJfsPudYU2V/GOU8IrnIHPzUEPtGVPHRsNRO3vcnKyliAu
         4MTg9fEvws5hDi0Ifx5bxyAzhzmKQoJJADHrs+axQVwo85LD/3bJrWqx0ojSi8RhgxOm
         qZ70AHZ/2g0zYcC9rYxDXjWNPFJxXQEizy3Na7FlPxZ+T9pBEBGoEMdKdxEgLc7g45Sf
         C0QX8A+aNAx9ywjx3tpb3WcpgKNZ7ETrXqlWiobsx9oR9x4ly0To+83JmqLXDi0csmZB
         beSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774010048; x=1774614848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3K8SJZxerjn7Jv5y3gL2e2Dax0E0bqqyMdQ4wn7A4ls=;
        b=AE68tTCqXQ3B+eBSOzVo6bsHSt6hKjl1jrXU1d4MQl4tNDnx1oR0AgtzLvd0AcJ2Nz
         KYe6qd67XZGF7NYvjPiLNEMh+Kwhok8MhA63ZXSXL1mA1ga3hwG4O4410LIOH5D00LZI
         gg9IFK1BHGVSAGnUoFqbe0DJzStl/oYXjn3F/AFxR+BlO1Db2JtWpBr8cZ5yAA0f0wKw
         ppQuhP4x3CFMNAAWXSuIT3vu3oxuaiutqiHJiu02PC59VTvHwGEWYwEh2cYdAT+Wg+VE
         8VhnVqbvZ6plBxf0jNZW9wwQRCiOObY1lKufJmk1kmehHyCCGRHyMmQymFPWY4yr2EWn
         LAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXW/yDPN0XdIfRg1v3CAIEwNPLlV4PJxI9VGhzzIcGLLyqmKScpPwApNPFyP6NPQXDRVVTROq+YtqP8Ww==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLWsGgYbzTsfr9RQNdvlsMIKIejSnRlKG4049m1yJjb7LuGeO2
	nodch2+vtPV6+TOuO8HSxMHt9kncGOJR+X/VCvsI4YPm8I8X7msWgmyqAAb70DUMT9OQPPC1yhf
	/ulXz/CgZHudqNGwdtD/lkrOusTPajKg=
X-Gm-Gg: ATEYQzxX/8i+ZaIWyJbqj8UewuaXTK2wbk2t0I+ohMHt/8dglawemhO4qfnZOlKi2C2
	qC64VcPSvhJedejBHI7XoesbY3PDoHnkflIJQZRsqi9qA6JFVL+leTp4FjOPlynrVYQmC+RDMV0
	hO81liue6rMJ/MIKDUMH3xKK+jGQzJ2QyEWSplMqM4GoDdE1R5TNgGIQKBGnmYor83W+OuU4Dy+
	1VilJNCbch5Dq/N+bvl/vQEAGoSjACBqkoUTgieIEyKIe2XHZs+a+ll0Z/ziRNlV1Xv33ZvL1R0
	cVPXlyivfzlgaUAmxSMU2kGHYL0fhvI3XTc8m1FlMQ==
X-Received: by 2002:a17:907:1604:b0:b97:fe6d:2e4a with SMTP id
 a640c23a62f3a-b982f0a95fbmr232459366b.10.1774010047484; Fri, 20 Mar 2026
 05:34:07 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260320122918.1726043-1-amir73il@gmail.com>
In-Reply-To: <20260320122918.1726043-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Mar 2026 13:33:55 +0100
X-Gm-Features: AaiRm50yxSl-GpcT9aAyYPhbaKvhkBm3eNaH28AUrvLwA3Ejcz4sEkf5zVBNIlU
Message-ID: <CAOQ4uxhsTG0mQCeiAw-8qGqjQo9HjRYfdRYQzPGXSgKb4udOiw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: allow backing file code to open an O_PATH file
 with negative dentry
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Paul Moore <paul@paul-moore.com>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2882-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:paul@paul-moore.com,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.825];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 743812DA52A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 1:29=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> The fields f_mapping and f_wb_err are irrelevant for the O_PATH file
> in backing_file_user_path_file().
>
> Create a dedicated helper kernel_path_file_open(), which skips all the
> generic code in do_dentry_open() and does only the essentials, so that
> the internal O_PATH file could be opened with a negative dentry.
>
> This is needed for backing_tmpfile_open() to open a backing O_PATH
> tmpfile before instantiating the dentry.
>
> The callers of backing_tmpfile_open() are responsible for calling
> backing_tmpfile_finish() after making the path positive.
>
> Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Christian,
>
> This patch fixes the syzbot report [1] that the
> backing_file_user_path_file() patch [2] introduces.

Sorry, forgot to mention that this patch applies on top of [2]
so the vfs CI is likely to fail to apply it.

The previous patch + fix are also available on my github
https://github.com/amir73il/linux/commits/user_path_file/

Thanks,
Amir.

>
> Following your feedback on v1, this version makes an effort to stay
> out of the way of main vfs execution paths and restrict the changes
> to backing_file users.
>
> This still introduced a temporary state of an O_PATH file with negative
> path, but only for a short time and only for backing_file users and
> ones that use backing_tmpfile_open() (i.e. only overlayfs), so the
> risk is minimal.
>
> WDYT?
>
> Thanks,
> Amir.
>
> Changes since v1:
> - Create helper for internal O_PATH open with negative path
> - Create backing_tmpfile_finish() API to fixup the negative path
>
> [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir73=
il@gmail.com/
>
>  fs/backing-file.c            |  6 ++++++
>  fs/file_table.c              | 14 ++++++++++++--
>  fs/internal.h                |  7 +++++++
>  fs/open.c                    | 34 ++++++++++++++++++++++++++++++----
>  fs/overlayfs/dir.c           |  2 ++
>  include/linux/backing-file.h |  1 +
>  6 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index d0a64c2103907..3357d624eac96 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -80,6 +80,12 @@ struct file *backing_tmpfile_open(const struct path *u=
ser_path,
>  }
>  EXPORT_SYMBOL(backing_tmpfile_open);
>
> +void backing_tmpfile_finish(struct file *file)
> +{
> +       backing_file_set_user_path_inode(file);
> +}
> +EXPORT_SYMBOL_GPL(backing_tmpfile_finish);
> +
>  struct backing_aio {
>         struct kiocb iocb;
>         refcount_t ref;
> diff --git a/fs/file_table.c b/fs/file_table.c
> index e8b4eb2bbff85..a4d1064d50896 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -69,11 +69,21 @@ EXPORT_SYMBOL_GPL(backing_file_user_path_file);
>
>  int backing_file_open_user_path(struct file *f, const struct path *path)
>  {
> -       /* open an O_PATH file to reference the user path - should not fa=
il */
> -       return WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> +       if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
> +               return -EIO;
> +       kernel_path_file_open(&backing_file(f)->user_path_file, path);
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(backing_file_open_user_path);
>
> +void backing_file_set_user_path_inode(struct file *f)
> +{
> +       if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
> +               return;
> +       file_set_d_inode(&backing_file(f)->user_path_file);
> +}
> +EXPORT_SYMBOL_GPL(backing_file_set_user_path_inode);
> +
>  static void destroy_file(struct file *f)
>  {
>         security_file_free(f);
> diff --git a/fs/internal.h b/fs/internal.h
> index 7c44a58627ba3..4a9e5e00678d9 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -109,6 +109,13 @@ struct file *alloc_empty_file_noaccount(int flags, c=
onst struct cred *cred);
>  struct file *alloc_empty_backing_file(int flags, const struct cred *cred=
,
>                                       const struct cred *user_cred);
>  int backing_file_open_user_path(struct file *f, const struct path *path)=
;
> +void backing_file_set_user_path_inode(struct file *f);
> +void kernel_path_file_open(struct file *f, const struct path *path);
> +
> +static inline void file_set_d_inode(struct file *f)
> +{
> +       f->f_inode =3D d_inode(f->f_path.dentry);
> +}
>
>  static inline void file_put_write_access(struct file *file)
>  {
> diff --git a/fs/open.c b/fs/open.c
> index 91f1139591abe..a7b3b04cd9ae7 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -884,10 +884,38 @@ static inline int file_get_write_access(struct file=
 *f)
>         return error;
>  }
>
> +static const struct file_operations empty_fops =3D {};
> +
> +static void do_path_file_open(struct file *f)
> +{
> +       f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> +       file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> +       f->f_op =3D &empty_fops;
> +}
> +
> +/**
> + * kernel_path_file_open - open an O_PATH file for kernel internal use
> + * @f:         pre-allocated file with f_flags and f_cred initialized
> + * @path:      path to reference (may have a negative dentry)
> + *
> + * Open a minimal O_PATH file that only references a path.
> + * Unlike vfs_open(), this does not require a positive dentry and does n=
ot
> + * set up f_mapping and other fields not needed for O_PATH.
> + * If path is negative at the time of this call, the caller is responsib=
le for
> + * callingn backing_file_set_user_path_inode() after making the path pos=
itive.
> +
> + */
> +void kernel_path_file_open(struct file *f, const struct path *path)
> +{
> +       f->__f_path =3D *path;
> +       path_get(&f->f_path);
> +       file_set_d_inode(f);
> +       do_path_file_open(f);
> +}
> +
>  static int do_dentry_open(struct file *f,
>                           int (*open)(struct inode *, struct file *))
>  {
> -       static const struct file_operations empty_fops =3D {};
>         struct inode *inode =3D f->f_path.dentry->d_inode;
>         int error;
>
> @@ -898,9 +926,7 @@ static int do_dentry_open(struct file *f,
>         f->f_sb_err =3D file_sample_sb_err(f);
>
>         if (unlikely(f->f_flags & O_PATH)) {
> -               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> -               file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> -               f->f_op =3D &empty_fops;
> +               do_path_file_open(f);
>                 return 0;
>         }
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 5fd32ccc134d2..4010c87e10196 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1408,6 +1408,8 @@ static int ovl_create_tmpfile(struct file *file, st=
ruct dentry *dentry,
>                         err =3D ovl_instantiate(dentry, inode, newdentry,=
 false, file);
>                         if (!err) {
>                                 file->private_data =3D of;
> +                               /* user_path_file was opened with a negat=
ive path */
> +                               backing_tmpfile_finish(realfile);
>                         } else {
>                                 dput(newdentry);
>                                 ovl_file_free(of);
> diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
> index 8afba93f3ce07..52ac51ada6ff9 100644
> --- a/include/linux/backing-file.h
> +++ b/include/linux/backing-file.h
> @@ -47,6 +47,7 @@ struct file *backing_tmpfile_open(const struct path *us=
er_path,
>                                   const struct cred *user_cred, int flags=
,
>                                   const struct path *real_parentpath,
>                                   umode_t mode, const struct cred *cred);
> +void backing_tmpfile_finish(struct file *file);
>  ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
>                                struct kiocb *iocb, int flags,
>                                struct backing_file_ctx *ctx);
> --
> 2.53.0
>

