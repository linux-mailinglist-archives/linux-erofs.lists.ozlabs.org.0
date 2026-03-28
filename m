Return-Path: <linux-erofs+bounces-3058-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCgdHGuRx2kDZQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3058-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 09:29:31 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9134DD57
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 09:29:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjVzk38LCz2yfK;
	Sat, 28 Mar 2026 19:29:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774686562;
	cv=pass; b=VKos7ScV3Q7iItDCU3hjU/SppWbtGHdiSZir4jhgyljkstwEQ1eUbjY38Fw2qeAcnpPryY79Z5tK11Ah3EWqR0pfX5Qiy3b/0CRSNhKZv0uINT1WnfQpha8Zlb9CpTnDLo3XKE0LZgursaylIUS3xuZANf2gpf1nmDPXgmunURjzzTZCJVlfr2sKOC8o1MwnfdBAu/+IQ4On+WA6iUb+IH6jdopSoR6F2FL+FZSFyaYTPUToYZ8AI5YdWlym8FGfFRgLxcnFIrSS91B8S/yY2zVqNCrOrOvHTG+4NYe6gNKao3M19LUo+Hi8rSu+kGBajtEXxprAl41Fg2lqUqWv8A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774686562; c=relaxed/relaxed;
	bh=LGi2J//y1hCXUvY1HptrsZDMHcxRStO1eH7BsZpdzbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzpaQXGJ2B5VNXiEiy0aZy6GqIFRp/EqSlya+e/vRroN/5On57uql0Gn3ofmGxblk/e54vTM7ba142WDZ3SOqbrZ/FZ9BjF8JM3QgUILXP5KGL3VgjnTw+Va4DtpvOQ2RDBpxdReADL7yz+koiGoGJgI9dCG7XyvA/Kvo12cozrsYuKucH8DwK9C+UbZAmD1cW/NoG3p3y6FqJ5Mq/diN944yS2/BISlD3BTBDbDq18RPPyVCBWMykuKARsaGBe0cLGpnrC88cOURxw9w5QH8uTBhIddwcrGkpRlSXVJ4HtA0XSi1JsXMcc/uGP/HB6DkccOJTkNeO6iXVLN18sKTg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F55vImh1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F55vImh1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjVzh4qYbz2xlK
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 19:29:19 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-66a82351490so5031162a12.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 01:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774686555; cv=none;
        d=google.com; s=arc-20240605;
        b=A/TqM0G432ViMfSkztttKAkFXr0fydI7/hQyDc3gJO9s/GzpcNHFcyRm0P6+uJ26g+
         lOf7mpyqTZLmAhsfRKMLjtNQtBcev91kUsDlps1bv/zhz84bthZd70hkKhT8CJPIchwC
         a7dbpikvVVwf/I/kPk+2deTW2l7RkirpR6plcOSVaFQU70DJq1yscpMu5ZnSwMdchidU
         aPNjGO0D9IsWOhA3WJ9/TTCNSODKoAMIPIWnSn/J/YMG5XrTJa3WEAR5yWA4ujGe19wM
         V9Z76XfsGRFOD9P3Xp9ezjcjBPAVqJVVgmN0tg7dyzocOIlx9hwXFfE5bke8ldmHjl2e
         /k1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LGi2J//y1hCXUvY1HptrsZDMHcxRStO1eH7BsZpdzbg=;
        fh=Pv1LsWeRGbEFRLVIWsb0GlpEIGxxVnHUXkXTAZV2s/Y=;
        b=IxBmvIK2qOw3WXozcM4qr1LteSghoa2uuukv7u2V6VmuHQYGIkjPoNSx2HbdRVZRY6
         t5Q7z1TaaCOYq5UW0GVTvwKHQqCcXkBIYUn7tS1PlR7QARjdkVjWBTLyxcH1S401ggE8
         J2tCPG550o1XJjgr5JqjTETzLpg3uG70xRaG6R8x4rs/ECP9CBR0ocOBxXnUujSCwZ/c
         FubDXSXlizwrlo1YnrottqLTY/YruQbi20tHU7rV1GfXERV+mJK0QQ23NGvonp+W2BuW
         bkaUyCllam2p2oZwPTIAinpks05taGkdhiAQw6y8Qae5oSRvqvemCdkyHOrqhlgxTJpm
         J0zA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774686555; x=1775291355; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGi2J//y1hCXUvY1HptrsZDMHcxRStO1eH7BsZpdzbg=;
        b=F55vImh1iyBjdHVrKPSVGfzXSD4tbw0CzhJQRuX71N7WFTUPfuuqU0bSph+0yiD0xx
         k1t1Azfvie7l1EB5WVAZ7B20jdqqo72KtCPtbvcTNrigcKSeyOrbZ74WXzbzvMVV2ys+
         bBEFfrIYl3XmrfnFSQsw07+jQHuAv5rhF6jJMh2VQFpz0VFhh03GdZ2C8YUvNgpkt5M6
         DstDUGv9ClkJKTi2CS6xMLHtsxfrRHyTuYrJIwJfyi6otrinB/LrAJE8ZYWw6+yYOHQa
         ndbePIQFlcRb2ziaT4oniL2wCzplzzgQWeTbFH/Gmlm6rFKLlCcGfijJIrjepniLDXNV
         VfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774686555; x=1775291355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGi2J//y1hCXUvY1HptrsZDMHcxRStO1eH7BsZpdzbg=;
        b=YdhlZk6eO/7uMhwD2znduxG3YZJXU/hySZJN3rxEXSQvStUrdOTjy4TQIPjpPBjYGY
         vPpTV8Z3jotDKivAQEun7B/wAFCGD+lT2OOR9A0bTQi6Rv8IxyIF4Y9TFkdcC84V6bDm
         ZJl2Q99RLMmpedMdJ8PzvckpXIOKL65o+KajAXH6jGZeHqBt/wXAEjdVdA5cpVur5Z/R
         TbBkHh6yrhokzwwRf6TD6FL1VuHd+EpL13/hwtBUWvKfzcKmuNUSitjmE2s63sq2mkl7
         DLIBQy+9eb5pU42zxk1LlkHasl0rKVKpwwAuiJPMGTB7jty0TUu8Yv3xGJobqtU+tvd2
         ZbfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDRuQfsB9yOx07DGDK0nlZ/QMj7Cr7pwtm1HKr8ZFwOuCzWSKxsdwEtK60DNBTR0a+gGDRne67dM8y5w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yypb/mp4bjUFyehkmoncBunYXdx1dttAqW2L5p6alP36GwUs2mQ
	N0AhgFqXs3JT7gR3tgZjVVbv8mooSlHi904MprvvyXMLiEukV4CPrCraY9Jj4p/AmarCfHt6BWo
	V6O1TijfF6WWCjXFWukPazXSfaVARREo=
X-Gm-Gg: ATEYQzwoZuk7paVO3qfr/8Nr4OgSFPdWFlyM4x3PwqfkZ17utVNVx0dvbBi5C1bcr7G
	VKQxvt6dRKTe/JzvkqqgKvk+02mCM+ZcCHGE2CLoTj3LNyFonx5PKKK7YVzIzxjQZAMm9YvqoSM
	Ay73rGvNeAmKPTXjam2JfJsbsflPlwN99W3XwFho9XW0RJ+Cp2ntUwwQ0Emn4X0Nt8jZ8swtVE7
	KJCEaDn32RZwAr2Yqgz8gIlBkWjJ1ed/t6GXmKcJObkgEb0pd0ho2RSbI5losi/8JYGLYYE9Kd5
	EUCPwHCoOuUV5l47Mo2OBApVzc7XpE+OI2TPFw+Xm+0pJusFNMfk
X-Received: by 2002:a05:6402:370b:b0:669:b5be:1202 with SMTP id
 4fb4d7f45d1cf-66b2a652236mr2888591a12.5.1774686554915; Sat, 28 Mar 2026
 01:29:14 -0700 (PDT)
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
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
In-Reply-To: <20260327220446.353103-5-paul@paul-moore.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 28 Mar 2026 09:29:03 +0100
X-Gm-Features: AQROBzAoJBb9PaDQrv_VGBI3UwjLF6z0_gtOD5OkJ5W93T7oeHAkRvcB2FVGKn4
Message-ID: <CAOQ4uxjvCYRLcRM-JGgtCPXKRB1agCBacN1tmR7hDR9TLdVS4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3058-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:brauner@kernel.org,m:miklos@szeredi.hu,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 12A9134DD57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Stacked filesystems such as overlayfs do not currently provide the
> necessary mechanisms for LSMs to properly enforce access controls on the
> mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> security blob is being added to the backing_file struct and the following
> new LSM hooks are being created:
>
>  security_backing_file_alloc()
>  security_backing_file_free()
>  security_mmap_backing_file()
>
> The first two hooks are to manage the lifecycle of the LSM security blob
> in the backing_file struct, while the third provides a new mmap() access
> control point for the underlying backing file.  It is also expected that
> LSMs will likely want to update their security_file_mprotect() callback
> to address issues with their mprotect() controls, but that does not
> require a change to the security_file_mprotect() LSM hook.
>
> There are a two other small changes to support these new LSM hooks.  We
> pass the user file associated with a backing file down to
> alloc_empty_backing_file() so it can be included in the
> security_backing_file_alloc() hook, and we constify the file struct field
> in the LSM common_audit_data struct to better support LSMs that need to
> pass a const file struct pointer into the common LSM audit code.
>
> Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> and supplying a fixup.
>
> Cc: stable@vger.kernel.org
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---

I 100% agree with Christian.
This is much better than my O_PATH file hack
It is also what Miklos had initially suggested.

I have a minor suggestion for API change though

>  fs/backing-file.c             |  18 ++++--
>  fs/erofs/ishare.c             |  10 +++-
>  fs/file_table.c               |  21 ++++++-
>  fs/fuse/passthrough.c         |   2 +-
>  fs/internal.h                 |   3 +-
>  fs/overlayfs/dir.c            |   2 +-
>  fs/overlayfs/file.c           |   2 +-
>  include/linux/backing-file.h  |   4 +-
>  include/linux/fs.h            |   1 +
>  include/linux/lsm_audit.h     |   2 +-
>  include/linux/lsm_hook_defs.h |   5 ++
>  include/linux/lsm_hooks.h     |   1 +
>  include/linux/security.h      |  22 ++++++++
>  security/lsm.h                |   1 +
>  security/lsm_init.c           |   9 +++
>  security/security.c           | 100 ++++++++++++++++++++++++++++++++++
>  16 files changed, 187 insertions(+), 16 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 45da8600d564..1f3bbfc75882 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -12,6 +12,7 @@
>  #include <linux/backing-file.h>
>  #include <linux/splice.h>
>  #include <linux/mm.h>
> +#include <linux/security.h>
>
>  #include "internal.h"
>
> @@ -29,14 +30,15 @@
>   * returned file into a container structure that also stores the stacked
>   * file's path, which can be retrieved using backing_file_user_path().
>   */
> -struct file *backing_file_open(const struct path *user_path, int flags,
> +struct file *backing_file_open(const struct file *user_file, int flags,
>                                const struct path *real_path,
>                                const struct cred *cred)
>  {
> +       const struct path *user_path =3D &user_file->f_path;
>         struct file *f;
>         int error;
>
> -       f =3D alloc_empty_backing_file(flags, cred);
> +       f =3D alloc_empty_backing_file(flags, cred, user_file);
>         if (IS_ERR(f))
>                 return f;
>
> @@ -52,15 +54,16 @@ struct file *backing_file_open(const struct path *use=
r_path, int flags,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_open);
>
> -struct file *backing_tmpfile_open(const struct path *user_path, int flag=
s,
> +struct file *backing_tmpfile_open(const struct file *user_file, int flag=
s,
>                                   const struct path *real_parentpath,
>                                   umode_t mode, const struct cred *cred)
>  {
>         struct mnt_idmap *real_idmap =3D mnt_idmap(real_parentpath->mnt);
> +       const struct path *user_path =3D &user_file->f_path;
>         struct file *f;
>         int error;
>
> -       f =3D alloc_empty_backing_file(flags, cred);
> +       f =3D alloc_empty_backing_file(flags, cred, user_file);
>         if (IS_ERR(f))
>                 return f;
>
> @@ -336,8 +339,13 @@ int backing_file_mmap(struct file *file, struct vm_a=
rea_struct *vma,
>
>         vma_set_file(vma, file);
>
> -       scoped_with_creds(ctx->cred)
> +       scoped_with_creds(ctx->cred) {
> +               ret =3D security_mmap_backing_file(vma, file, user_file);
> +               if (ret)
> +                       return ret;
> +
>                 ret =3D vfs_mmap(vma->vm_file, vma);
> +       }
>
>         if (ctx->accessed)
>                 ctx->accessed(user_file);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 829d50d5c717..ec3fc5ac1a55 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/xxhash.h>
>  #include <linux/mount.h>
> +#include <linux/security.h>
>  #include "internal.h"
>  #include "xattr.h"
>
> @@ -106,7 +107,8 @@ static int erofs_ishare_file_open(struct inode *inode=
, struct file *file)
>
>         if (file->f_flags & O_DIRECT)
>                 return -EINVAL;
> -       realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred());
> +       realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred(),
> +                                           file);
>         if (IS_ERR(realfile))
>                 return PTR_ERR(realfile);
>         ihold(sharedinode);
> @@ -150,8 +152,14 @@ static ssize_t erofs_ishare_file_read_iter(struct ki=
ocb *iocb,
>  static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *v=
ma)
>  {
>         struct file *realfile =3D file->private_data;
> +       int err;
>
>         vma_set_file(vma, realfile);
> +
> +       err =3D security_mmap_backing_file(vma, realfile, file);
> +       if (err)
> +               return err;
> +
>         return generic_file_readonly_mmap(file, vma);
>  }
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index aaa5faaace1e..0bdc26cae138 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -50,6 +50,7 @@ struct backing_file {
>                 struct path user_path;
>                 freeptr_t bf_freeptr;
>         };

Shouldn't we wrap this with
#ifdef CONFIG_SECURITY

> +       void *security;

please initialize it in init_file()

>  };
>
>  #define backing_file(f) container_of(f, struct backing_file, file)
> @@ -66,6 +67,11 @@ void backing_file_set_user_path(struct file *f, const =
struct path *path)
>  }
>  EXPORT_SYMBOL_GPL(backing_file_set_user_path);
>
> +void *backing_file_security(const struct file *f)
> +{
> +       return backing_file(f)->security;

I think LSM code should be completely responsible for this ptr
assignment/free so you should export

void **backing_file_security_ptr(const struct file *f)
{
       return &backing_file(f)->security;
}

> +
>  static inline void file_free(struct file *f)
>  {
>         security_file_free(f);
> @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
>                 percpu_counter_dec(&nr_files);
>         put_cred(f->f_cred);
>         if (unlikely(f->f_mode & FMODE_BACKING)) {
> -               path_put(backing_file_user_path(f));
> -               kmem_cache_free(bfilp_cachep, backing_file(f));
> +               struct backing_file *ff =3D backing_file(f);
> +
> +               security_backing_file_free(&ff->security);

Why do you need to add this in vfs code?

Can't you do the same in security_file_free(f)?
        if (unlikely(f->f_mode & FMODE_BACKING))
                security_backing_file_free(backing_file_security_ptr(f));


> +               path_put(&ff->user_path);
> +               kmem_cache_free(bfilp_cachep, ff);
>         } else {
>                 kmem_cache_free(filp_cachep, f);
>         }
> @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, co=
nst struct cred *cred)
>   * This is only for kernel internal use, and the allocate file must not =
be
>   * installed into file tables or such.
>   */
> -struct file *alloc_empty_backing_file(int flags, const struct cred *cred=
)
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred=
,
> +                                     const struct file *user_file)
>  {
>         struct backing_file *ff;
>         int error;
> @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, con=
st struct cred *cred)
>         }
>
>         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> +       error =3D security_backing_file_alloc(&ff->security, user_file);>=
 +       if (unlikely(error)) {
> +               fput(&ff->file);
> +               return ERR_PTR(error);
> +       }
>         return &ff->file;
>  }
>  EXPORT_SYMBOL_GPL(alloc_empty_backing_file);

Maybe, and I am not sure,
alloc_empty_backing_file() should call ONLY
            error =3D security_backing_file_alloc(&ff->file, user_file);

Instead of security_file_alloc() AND security_backing_file_alloc()
and security_backing_file_alloc() can make use of
backing_file_security_ptr() accessor internally?

I think this will further abstract LSM implementation details from vfs
and avoid the need to spray #ifdef SECURITY in vfs code.

WDYT?

Thanks for following through with this elegant and clean API!
Amir.

