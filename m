Return-Path: <linux-erofs+bounces-3191-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBS6IXNbz2kXvgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3191-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:17:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F723915DF
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 08:17:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn7mZ3KMVz2ygT;
	Fri, 03 Apr 2026 17:17:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775197038;
	cv=pass; b=dRIwVw4B3qHnAmUs+6WnzcMVUjt8pXzAfKx4K0tn1eyI13M4SJiQMJHEENPhSOR6Nw/xhQMRtezrID2yWaPV6QjbRuAV+jX1/7Bu35s+eH0T9Y4LuA0T0gxGspPfDOtvLajR7RDoblgsSJQkMqrOcFhWXVzA8Ja7U3fX4cIvHe74wUnwAGXYA06ZkiwtM2edpwFVwQof3ufAKVAPDyx7+fwk86YjhX7ujuGFUf31BOHaQfJoOkrng3UZXy4IS/6xSZJVw4sICjRhenjGu/Jq4qqOJTmp9jJ7/ZnRxdDl6enapeEFhVG5zrkuGCUFxgqpZ3DP6pQXxKvNVafM+YJqEw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775197038; c=relaxed/relaxed;
	bh=T2ARNn36t/8nKb8lFPnRUge6KFlcIwa4Ay/uiEuGZEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK8Pxq/QaJYjlSINp8Y2Bv8WZ75a50ohTkL5dE3gxCyJT3Mf3OFSRpw4FStUKM+/jzXK3JT1NbCogfGuF7u9v39X38vWnj/Dc/+0n9XPkV3sZHTCdJFNPAeDtCEoBBTBbxr8HmJTvNvZI1b0oHdZUAQWPmJOB9cEDbwdzRaGU1wjGn78rlzvghiRNuXJh66Tl/NPwmZ3jP1VJGC/VyXR00viXyZTqn91F5ljpSIduiTr5YSQLb+YVdPiGvom+ipaf10sUcrsHaBmAuf6jET+lJg0EcoZMUD2HlzSWgNV6VrXSvUTB3oAM9lx9VAIvOss2dXaaEOAHFDrqpgwsWBblA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hmdONIbN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hmdONIbN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn7mY1Hg6z2xln
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 17:17:16 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-66dd1b5bb6aso2788781a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 23:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775197034; cv=none;
        d=google.com; s=arc-20240605;
        b=L2dBNiPViwulgNwowJkAqNF2to46nf9m0RYnQ1yROlLS3taQGlN+iKAZclBkjaR49G
         Kq4Zb2F6AeOhWUjCGxGrDk7UnC5PkjbdlT4zFATwSa4uJaXFVYA5gINW091lWPgnieGF
         6MmVrt6ETrYuuCLLAGfsXXDalnMM0yULyQeXOUX26gC0hB3905WNMwRmF3gxH/7p5wLm
         9nLXKCgvAZg6nnzyz/YjZdd765dsaWQbi0NtXe/lUQXSEVCxGnrvbArS8D6lSzkmv08Y
         KjLj/51tOWmOB3xLAtTsWNqaLqyh+hqREHya1X4br8pEZOdLJHsWm4AWMBaD/4GCgwu4
         fx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2ARNn36t/8nKb8lFPnRUge6KFlcIwa4Ay/uiEuGZEU=;
        fh=Lw+T8d2QhZSy/DLkCPgWloiqf6D+2EwyOMyHC3Z1+Eo=;
        b=XxtAX3Sm59GvIJkY+zwbzyGiCAl4eqBA1/5b4TQ/Nf8LKYRm5eKAELQXXoJEXtYt4x
         xrOZbNIJPldQ+yT08OvF/bti+6xjIVOe8qHEfT9RfWXKAH0LwVxIBy62VsX/PI71cooU
         6cN54KUk8umEbeW1xi/QOj9G7BT4en95qqKdjqCBI4WgSWKcMDDLTdOpuLwB5aFdgL0e
         AwFygcV7vaEa2SY1EJDwPvJW0paIDdZRcWd0j9vQQ/xIRgB5e/QDo3zvYTcevFa+YQLb
         BDuPWzI5wGG8BK+z08Tr/JF5MGAlOd8mpLLml6gOhSsRMVvEwighSSSyikAQEhSD5lhW
         jLmg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775197034; x=1775801834; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2ARNn36t/8nKb8lFPnRUge6KFlcIwa4Ay/uiEuGZEU=;
        b=hmdONIbNLEUroRCRmf69Xjjh/MU52DDMaorfPZVrsc818Uy/Bgd03IWMhtKIDcyYuG
         AZ9Cq2F9QZ0dDFr6BrDmc8iDQ8JM2TfocEtAWjJj3XK548s7QjrCZY1MT5ndjkYDXInD
         C52BXDxxz1drEUyuXVDkQSDkrhB1r4F68e5XeGQgKDAi9aei0hClI1d6mXSSs3KydUIT
         syQmi8e+yTTso3eabksPravwKTM+XG2c8kKYQVodVVF/qOeRH6kzsFSV6m9rAvKxtOr6
         c87deH8qwuQygezJ8WvYcZnHraLb967eaq22c7dOC+pu7Cwwe2TKLMFN0ySEbRCpG1K0
         ZYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775197034; x=1775801834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2ARNn36t/8nKb8lFPnRUge6KFlcIwa4Ay/uiEuGZEU=;
        b=Hem96jOaQ2VuX9u9XVcebBpWQ/pDWALESDg+eDCJ8SDYuJrIP+DTCefH6lSz2Im2ZJ
         9SY4qNBkhlOt5xsGpUV5HFmlTNX5YFAAnMG02dNM/zfyR9Ri/Y9/EHvW7f3CWvbfPELu
         bFRxPm6HcccPfQT4AGW+hBEYZVCeTSZLe5uAyxVuLi5BZ/Kg/BMoWI5/qi4spq51CZHR
         GdH0r218rSUpSBayrlYzPIsNcvwftjONRlfLx2BnQHjrIIEoKtjLKd8/if4tUesp+LFm
         mxKOWIhj/xxRGYlK5YDgonhibwU+kCv+XTQuGjIlW/9BjccLPoQtI/NaKZiThH8AbQky
         lf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPOUFlcR9dxRI4xrbo6e6AOTPLxaHEi1xwAo6EnW1LfT3qNHPw8JBvLu9XyxaZmRKxOtUq2rGrNKy3RQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0vkHbIwII0X+6vZuRpo7bxUisJSg0IMrFXP1pVNNVBxOPy8Yb
	KMGVv32SRVXQJgI3M94i/8P6g8ViAe7lWcKk+bCr6rF/wRrpG6eruV+zpS7SLnP1lrD6DGhpqu/
	PVRpwLRZ7HaOU5E8NjAh7j5DM63g/ud4=
X-Gm-Gg: AeBDievyZzuhpUXZj2al7ovN9xuUaHwSa/hiBGik3+3eA2Z4ge9doSOAFe61B434sFr
	LDsYJLWv0oGM81lkU3AeGzONNKh75ZQKFssFZTTvvEOSj2caBkZYWWbXlEtrADxuP82ydhpqsci
	2x/MY9q2sHbUNmR/H9uXzXm8YZnw7nb7Zh/Exc9j/ljlKmYQ2ZtUVJiWEuRUUpkiN85sDno/cVA
	Uo8ShsETPvr4ETBSv86qdQUFwyPVWjVIVEyTuu04CHlE4bcSRc4hqyTf3KqCcYTCR2kZkAtpNpj
	K//AGO5DipvfKw8eY9O8GfO4CnewHKDvBjajsuyUAg==
X-Received: by 2002:a05:6402:4449:b0:66d:d077:d18a with SMTP id
 4fb4d7f45d1cf-66e3f4da943mr834911a12.12.1775197033329; Thu, 02 Apr 2026
 23:17:13 -0700 (PDT)
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
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
In-Reply-To: <20260403030848.731867-8-paul@paul-moore.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 3 Apr 2026 08:17:01 +0200
X-Gm-Features: AQROBzDmsH9YGllMb7aE-zIYe-TTbvJvK67fkAXHUx2ZVad9dbe5P_NGte21nOI
Message-ID: <CAOQ4uxjr=Mc5wQizyhxW3=esCLQvZub1xm3G3SRkUwUPBbPh_A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3191-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: A3F723915DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 5:09=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Can't say much about selinux implementation, but
for the use of backing file API and the concept solution

Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  security/selinux/hooks.c          | 256 +++++++++++++++++++++---------
>  security/selinux/include/objsec.h |  11 ++
>  2 files changed, 196 insertions(+), 71 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..76e0fb7dcb36 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1745,6 +1745,60 @@ static inline int file_path_has_perm(const struct =
cred *cred,
>  static int bpf_fd_pass(const struct file *file, u32 sid);
>  #endif
>
> +static int __file_has_perm(const struct cred *cred, const struct file *f=
ile,
> +                          u32 av, bool bf_user_file)
> +
> +{
> +       struct common_audit_data ad;
> +       struct inode *inode;
> +       u32 ssid =3D cred_sid(cred);
> +       u32 tsid_fd;
> +       int rc;
> +
> +       if (bf_user_file) {
> +               struct backing_file_security_struct *bfsec;
> +               const struct path *path;
> +
> +               if (WARN_ON(!(file->f_mode & FMODE_BACKING)))
> +                       return -EIO;
> +
> +               bfsec =3D selinux_backing_file(file);
> +               path =3D backing_file_user_path(file);
> +               tsid_fd =3D bfsec->uf_sid;
> +               inode =3D d_inode(path->dentry);
> +
> +               ad.type =3D LSM_AUDIT_DATA_PATH;
> +               ad.u.path =3D *path;
> +       } else {
> +               struct file_security_struct *fsec =3D selinux_file(file);
> +
> +               tsid_fd =3D fsec->sid;
> +               inode =3D file_inode(file);
> +
> +               ad.type =3D LSM_AUDIT_DATA_FILE;
> +               ad.u.file =3D file;
> +       }
> +
> +       if (ssid !=3D tsid_fd) {
> +               rc =3D avc_has_perm(ssid, tsid_fd, SECCLASS_FD, FD__USE, =
&ad);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* regardless of backing vs user file, use the underlying file he=
re */
> +       rc =3D bpf_fd_pass(file, ssid);
> +       if (rc)
> +               return rc;
> +#endif
> +
> +       /* av is zero if only checking access to the descriptor. */
> +       if (av)
> +               return inode_has_perm(cred, inode, av, &ad);
> +
> +       return 0;
> +}
> +
>  /* Check whether a task can use an open file descriptor to
>     access an inode in a given way.  Check access to the
>     descriptor itself, and then use dentry_has_perm to
> @@ -1753,41 +1807,10 @@ static int bpf_fd_pass(const struct file *file, u=
32 sid);
>     has the same SID as the process.  If av is zero, then
>     access to the file is not checked, e.g. for cases
>     where only the descriptor is affected like seek. */
> -static int file_has_perm(const struct cred *cred,
> -                        struct file *file,
> -                        u32 av)
> +static inline int file_has_perm(const struct cred *cred,
> +                               const struct file *file, u32 av)
>  {
> -       struct file_security_struct *fsec =3D selinux_file(file);
> -       struct inode *inode =3D file_inode(file);
> -       struct common_audit_data ad;
> -       u32 sid =3D cred_sid(cred);
> -       int rc;
> -
> -       ad.type =3D LSM_AUDIT_DATA_FILE;
> -       ad.u.file =3D file;
> -
> -       if (sid !=3D fsec->sid) {
> -               rc =3D avc_has_perm(sid, fsec->sid,
> -                                 SECCLASS_FD,
> -                                 FD__USE,
> -                                 &ad);
> -               if (rc)
> -                       goto out;
> -       }
> -
> -#ifdef CONFIG_BPF_SYSCALL
> -       rc =3D bpf_fd_pass(file, cred_sid(cred));
> -       if (rc)
> -               return rc;
> -#endif
> -
> -       /* av is zero if only checking access to the descriptor. */
> -       rc =3D 0;
> -       if (av)
> -               rc =3D inode_has_perm(cred, inode, av, &ad);
> -
> -out:
> -       return rc;
> +       return __file_has_perm(cred, file, av, false);
>  }
>
>  /*
> @@ -3825,6 +3848,17 @@ static int selinux_file_alloc_security(struct file=
 *file)
>         return 0;
>  }
>
> +static int selinux_backing_file_alloc(struct file *backing_file,
> +                                     const struct file *user_file)
> +{
> +       struct backing_file_security_struct *bfsec;
> +
> +       bfsec =3D selinux_backing_file(backing_file);
> +       bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +
> +       return 0;
> +}
> +
>  /*
>   * Check whether a task has the ioctl permission and cmd
>   * operation to an inode.
> @@ -3942,42 +3976,55 @@ static int selinux_file_ioctl_compat(struct file =
*file, unsigned int cmd,
>
>  static int default_noexec __ro_after_init;
>
> -static int file_map_prot_check(struct file *file, unsigned long prot, in=
t shared)
> +static int __file_map_prot_check(const struct cred *cred,
> +                                const struct file *file, unsigned long p=
rot,
> +                                bool shared, bool bf_user_file)
>  {
> -       const struct cred *cred =3D current_cred();
> -       u32 sid =3D cred_sid(cred);
> -       int rc =3D 0;
> +       struct inode *inode =3D NULL;
> +       bool prot_exec =3D prot & PROT_EXEC;
> +       bool prot_write =3D prot & PROT_WRITE;
> +
> +       if (file) {
> +               if (bf_user_file)
> +                       inode =3D d_inode(backing_file_user_path(file)->d=
entry);
> +               else
> +                       inode =3D file_inode(file);
> +       }
> +
> +       if (default_noexec && prot_exec &&
> +           (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
> +               int rc;
> +               u32 sid =3D cred_sid(cred);
>
> -       if (default_noexec &&
> -           (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) =
||
> -                                  (!shared && (prot & PROT_WRITE)))) {
>                 /*
> -                * We are making executable an anonymous mapping or a
> -                * private file mapping that will also be writable.
> -                * This has an additional check.
> +                * We are making executable an anonymous mapping or a pri=
vate
> +                * file mapping that will also be writable.
>                  */
> -               rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
> -                                 PROCESS__EXECMEM, NULL);
> +               rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__=
EXECMEM,
> +                                 NULL);
>                 if (rc)
> -                       goto error;
> +                       return rc;
>         }
>
>         if (file) {
> -               /* read access is always possible with a mapping */
> +               /* "read" always possible, "write" only if shared */
>                 u32 av =3D FILE__READ;
> -
> -               /* write access only matters if the mapping is shared */
> -               if (shared && (prot & PROT_WRITE))
> +               if (shared && prot_write)
>                         av |=3D FILE__WRITE;
> -
> -               if (prot & PROT_EXEC)
> +               if (prot_exec)
>                         av |=3D FILE__EXECUTE;
>
> -               return file_has_perm(cred, file, av);
> +               return __file_has_perm(cred, file, av, bf_user_file);
>         }
>
> -error:
> -       return rc;
> +       return 0;
> +}
> +
> +static inline int file_map_prot_check(const struct cred *cred,
> +                                     const struct file *file,
> +                                     unsigned long prot, bool shared)
> +{
> +       return __file_map_prot_check(cred, file, prot, shared, false);
>  }
>
>  static int selinux_mmap_addr(unsigned long addr)
> @@ -3993,36 +4040,80 @@ static int selinux_mmap_addr(unsigned long addr)
>         return rc;
>  }
>
> -static int selinux_mmap_file(struct file *file,
> -                            unsigned long reqprot __always_unused,
> -                            unsigned long prot, unsigned long flags)
> +static int selinux_mmap_file_common(const struct cred *cred, struct file=
 *file,
> +                                   unsigned long prot, bool shared)
>  {
> -       struct common_audit_data ad;
> -       int rc;
> -
>         if (file) {
> +               int rc;
> +               struct common_audit_data ad;
> +
>                 ad.type =3D LSM_AUDIT_DATA_FILE;
>                 ad.u.file =3D file;
> -               rc =3D inode_has_perm(current_cred(), file_inode(file),
> -                                   FILE__MAP, &ad);
> +               rc =3D inode_has_perm(cred, file_inode(file), FILE__MAP, =
&ad);
>                 if (rc)
>                         return rc;
>         }
>
> -       return file_map_prot_check(file, prot,
> -                                  (flags & MAP_TYPE) =3D=3D MAP_SHARED);
> +       return file_map_prot_check(cred, file, prot, shared);
> +}
> +
> +static int selinux_mmap_file(struct file *file,
> +                            unsigned long reqprot __always_unused,
> +                            unsigned long prot, unsigned long flags)
> +{
> +       return selinux_mmap_file_common(current_cred(), file, prot,
> +                                       (flags & MAP_TYPE) =3D=3D MAP_SHA=
RED);
> +}
> +
> +/**
> + * selinux_mmap_backing_file - Check mmap permissions on a backing file
> + * @vma: memory region
> + * @backing_file: stacked filesystem backing file
> + * @user_file: user visible file
> + *
> + * This is called after selinux_mmap_file() on stacked filesystems, and =
it
> + * is this function's responsibility to verify access to @backing_file a=
nd
> + * setup the SELinux state for possible later use in the mprotect() code=
 path.
> + *
> + * By the time this function is called, mmap() access to @user_file has =
already
> + * been authorized and @vma->vm_file has been set to point to @backing_f=
ile.
> + *
> + * Return zero on success, negative values otherwise.
> + */
> +static int selinux_mmap_backing_file(struct vm_area_struct *vma,
> +                                    struct file *backing_file,
> +                                    struct file *user_file __always_unus=
ed)
> +{
> +       unsigned long prot =3D 0;
> +
> +       /* translate vma->vm_flags perms into PROT perms */
> +       if (vma->vm_flags & VM_READ)
> +               prot |=3D PROT_READ;
> +       if (vma->vm_flags & VM_WRITE)
> +               prot |=3D PROT_WRITE;
> +       if (vma->vm_flags & VM_EXEC)
> +               prot |=3D PROT_EXEC;
> +
> +       return selinux_mmap_file_common(backing_file->f_cred, backing_fil=
e,
> +                                       prot, vma->vm_flags & VM_SHARED);
>  }
>
>  static int selinux_file_mprotect(struct vm_area_struct *vma,
>                                  unsigned long reqprot __always_unused,
>                                  unsigned long prot)
>  {
> +       int rc;
>         const struct cred *cred =3D current_cred();
>         u32 sid =3D cred_sid(cred);
> +       const struct file *file =3D vma->vm_file;
> +       bool backing_file;
> +       bool shared =3D vma->vm_flags & VM_SHARED;
> +
> +       /* check if we need to trigger the "backing files are awful" mode=
 */
> +       backing_file =3D file && (file->f_mode & FMODE_BACKING);
>
>         if (default_noexec &&
>             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> -               int rc =3D 0;
>                 /*
>                  * We don't use the vma_is_initial_heap() helper as it ha=
s
>                  * a history of problems and is currently broken on syste=
ms
> @@ -4036,11 +4127,15 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>                     vma->vm_end <=3D vma->vm_mm->brk) {
>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECHEAP, NULL);
> -               } else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
> +                       if (rc)
> +                               return rc;
> +               } else if (!file && (vma_is_initial_stack(vma) ||
>                             vma_is_stack_for_current(vma))) {
>                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>                                           PROCESS__EXECSTACK, NULL);
> -               } else if (vma->vm_file && vma->anon_vma) {
> +                       if (rc)
> +                               return rc;
> +               } else if (file && vma->anon_vma) {
>                         /*
>                          * We are making executable a file mapping that h=
as
>                          * had some COW done. Since pages might have been
> @@ -4048,13 +4143,29 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>                          * modified content.  This typically should only
>                          * occur for text relocations.
>                          */
> -                       rc =3D file_has_perm(cred, vma->vm_file, FILE__EX=
ECMOD);
> +                       rc =3D __file_has_perm(cred, file, FILE__EXECMOD,
> +                                            backing_file);
> +                       if (rc)
> +                               return rc;
> +                       if (backing_file) {
> +                               rc =3D file_has_perm(file->f_cred, file,
> +                                                  FILE__EXECMOD);
> +                               if (rc)
> +                                       return rc;
> +                       }
>                 }
> +       }
> +
> +       rc =3D __file_map_prot_check(cred, file, prot, shared, backing_fi=
le);
> +       if (rc)
> +               return rc;
> +       if (backing_file) {
> +               rc =3D file_map_prot_check(file->f_cred, file, prot, shar=
ed);
>                 if (rc)
>                         return rc;
>         }
>
> -       return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_S=
HARED);
> +       return 0;
>  }
>
>  static int selinux_file_lock(struct file *file, unsigned int cmd)
> @@ -7393,6 +7504,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after=
_init =3D {
>         .lbs_cred =3D sizeof(struct cred_security_struct),
>         .lbs_task =3D sizeof(struct task_security_struct),
>         .lbs_file =3D sizeof(struct file_security_struct),
> +       .lbs_backing_file =3D sizeof(struct backing_file_security_struct)=
,
>         .lbs_inode =3D sizeof(struct inode_security_struct),
>         .lbs_ipc =3D sizeof(struct ipc_security_struct),
>         .lbs_key =3D sizeof(struct key_security_struct),
> @@ -7498,9 +7610,11 @@ static struct security_hook_list selinux_hooks[] _=
_ro_after_init =3D {
>
>         LSM_HOOK_INIT(file_permission, selinux_file_permission),
>         LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
> +       LSM_HOOK_INIT(backing_file_alloc, selinux_backing_file_alloc),
>         LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
>         LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
>         LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
> +       LSM_HOOK_INIT(mmap_backing_file, selinux_mmap_backing_file),
>         LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
>         LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
>         LSM_HOOK_INIT(file_lock, selinux_file_lock),
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 5bddd28ea5cb..b19e5d978e82 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -88,6 +88,10 @@ struct file_security_struct {
>         u32 pseqno; /* Policy seqno at the time of file open */
>  };
>
> +struct backing_file_security_struct {
> +       u32 uf_sid; /* associated user file fsec->sid */
> +};
> +
>  struct superblock_security_struct {
>         u32 sid; /* SID of file system superblock */
>         u32 def_sid; /* default SID for labeling */
> @@ -195,6 +199,13 @@ static inline struct file_security_struct *selinux_f=
ile(const struct file *file)
>         return file->f_security + selinux_blob_sizes.lbs_file;
>  }
>
> +static inline struct backing_file_security_struct *
> +selinux_backing_file(const struct file *backing_file)
> +{
> +       void *blob =3D backing_file_security(backing_file);
> +       return blob + selinux_blob_sizes.lbs_backing_file;
> +}
> +
>  static inline struct inode_security_struct *
>  selinux_inode(const struct inode *inode)
>  {
> --
> 2.53.0
>

