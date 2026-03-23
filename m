Return-Path: <linux-erofs+bounces-2966-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAf8KnerwWmUUQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2966-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 22:07:03 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7162FD93F
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 22:07:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffm2B42fLz2xPL;
	Tue, 24 Mar 2026 08:06:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774300018;
	cv=pass; b=oNjrclO1BQzcU3WPWU2g+IjjQP+UcyB4orxNP+toD2I8fnhvwTyrBPQyHL8x3BgkeXJ188bWcydsJXDo1m8/EksUUuzdVtCdJLE/c619IrswGwWwIeLZQsUxtJOcwUaOBP/9ZpYqjo2BfEgY6HuOnd2k/f/OaHc+VvePhdy7GxTiK4wmULe7GtL6NGrtc1SOASWFJ/SvEycyuOTsZfErRKcs39vEdEXPyGNkKA462MSCLQhcCw8oK0nKH9U1rGb9/jcHmzYt9cgWDyBfUxiIFwyw11sEgdkXV6QV1637UobKSKjj603FuSNcltXMKG369FajAqEbs7CYJ/ZgpXxI0A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774300018; c=relaxed/relaxed;
	bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wxc/DdbqoFgBcXx8y73K18JV9go0KFEhggspniNqRItBOHyt7D+P9T7H88/4lqoDZHSMxhWUk+lgfXYz5GVkUP1jHOaTQ9gNpp2ejHBqaiBxJrF2op6820RsLX7K+bvOyZCBKLeJFcu5by82FCOZWtKukSqyZryDuN7dd/oprnTttcn/qWypwIaovoQ6D375isanXVSIzyPqPwjKXE+79w5ON4tVYCfnHy5S7Eoga4xhSVyhPXVGhjqOn2vv+yiigiBfGLDafQl5/B46ur+wDCem0MjWtzXBP1Yt8WoPXKolsTrxjTOe9+rvq/jv5a/Ixhd2EuKKSyDBnMI+a7AlNg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=CCLNcTqY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=CCLNcTqY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffm291k2Pz2xMY
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 08:06:56 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c74280e3468so1246411a12.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 14:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774300012; cv=none;
        d=google.com; s=arc-20240605;
        b=RyT7t7rISFWfJpTrZKpk/4c9G7cGSE3AdUmYD5Wk2Chfk6X2ATjMw5Ngpguk+GJ4ip
         ltbpmYTuoiuaGMOP24De6bBq6oz9/+kmerRnarv5Nf3TzPXzfVo5rRzqQg1HAEkfkCvi
         BPUO5NVZazmvmRYvKVvptl3Q/DpOzdkeAfiD9biLf9vdQTA/amyHpepya9VBcnFQX7YG
         6e746n8CbsxTJdreuKyctRgCdcwgENbKsY6pKkqYrcZfSIT5r4rvuL63/hQxZ/Y6i+aC
         15WtRjHxpy9H5dTtcFqB+L6QAbuSPEwgMD3/zT4Y+s1UvBow2hmk3drERYGqm+bF8UZK
         Dgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        fh=O3a9wwNcYgkEQpnXWevzW7B90Qz/b1halU2mCNQmKD4=;
        b=Qz8wsMdB4eHHxX50QMtwfUgbkl29/DbtjzJypK70eSEaLAEc2S5km3zB/BOkqH+wKT
         67XLQwyqb4cf+DaqLdSewOCcwxTqpVUteCmgX10iBKklgXZNPomeUvbJZ0f6Fvcbd6s6
         eF5YQYdL+4Ty2PcKifUKPIXG3zXluNxYUhsZfQ48Kez+oLuHqzFgxC154cGGS3QY4hb/
         7S19COZgtub1gW2iHspI83xh0yPme+Y5FMQ6Nk70aFqI4Ebx/dNAFUzafol6heoVyXbJ
         v/vY/6QuXMQ7SRPEXbQaApWB1ghl+9louUmK+RPc9f3NyzwQOY7AXL6bBQHNU3Q1e2tQ
         NG1w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774300012; x=1774904812; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=CCLNcTqYrDKvdshT2b5LZZzIsntHw9msWGLoHfAEW8RNL42gDWfrzhvSF/7/38g7hX
         UsKh9aL5LGVQdz24NqDuF7KFW2uvQsGHK+c4VndUvZmKVYVXaRI1v6bsx7QecH39SPJz
         CbaYv/9ckfJkn2Bqs3DgSSKD4OAPaffGWiBhK3DnKn0/9OUtULWNVY07MVbO0Q3OjZiO
         s9Wfm0YiqlwRdpXumEmaIJHCQzjXf6UahLaVZvjef/FXbaAWLXP1eiQmvQFEONnULWTz
         rndPXcvpLoqmuXq4kjuclvRIGquCjIOQnR4M35Yq5M441PUdxm5VGtvKts2O7EdfnkoP
         0sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300012; x=1774904812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=PJRs5fkcQ1YSZoACpxgAMe/8ibu6zJzkaWkWHp95rlen3CoLsb3RYCCs2sK/Vy6k2j
         flK98KbHfwZ9oFXGDhktNkmUQs72vkypUneN36dqH5mEFTuslhymP2NmfU4vE1eOBDCw
         SRCpipqUpVb2dtX5ibAtbF1iJ64eLaZ9stYk+Tiy/4wwFAqEyd/NL5pJPy25EW437iMQ
         rM8xaIk+/nT1g7U8Iug7CPGpgtOqNBWB5KwMn2rCe2KSHjpVR1qYJ424gaadlG91YFia
         FMmdqexKzqRpGACH0FzUxmVZucoG7G9JDvhRmI6KUY653nTrYen6TfQMFVny4SiCpPId
         0MlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU4KQmyxbREIr/B96fNyYKi0Gj1V571FA97uv6OcotGQcZBZ2kLhj3dvBvOF+BsUYsonOz7tbntg6hKQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOvMJzrxvK6VlbT7zl4/3PhVUTZc2zvNn3Q7Pbci+9zIcKUoNR
	Y0HKK58+K+x3ypPvNBjjb9ri84/PooWtvdyUumwHaZ7DfJGXyQyOQnFt/cZcAxg4+tBCs8Yhdy0
	3iSD5CsrSe3SUnd1DFYt6s2eFn8Im6aWHrNzVnN0c
X-Gm-Gg: ATEYQzx4z4FiwXVAEx1D2RcaQzNJxuUimj4XwFP+ec4qOnlyPET+py2+nI0FaG1V4eC
	URbfcuV9r6HrVNrI/QSXTZlVCbOjS2r7EuqlakdxaMBN9voQDjsFSfPh/pAFpv4QE2086X7anx9
	y+aJLiLSY3HsmafvE0btZ37ow9iqRW0G5VLG9OEhHQVVEVPNvQ92QOu00gR2XrsfvpT/QFySazN
	e1BGrAohjwsvoDy9FqhM4Sf4HMAVy88PkiHYFQirTLV0Y7BOX8/GvY+7zeBNt6Gq/9Gvbm/Vk0C
	fpeozYA=
X-Received: by 2002:a05:6a20:a124:b0:398:9923:749f with SMTP id
 adf61e73a8af0-39bcea1d2c7mr12205176637.20.1774300012580; Mon, 23 Mar 2026
 14:06:52 -0700 (PDT)
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
References: <20260323042510.3331778-4-paul@paul-moore.com> <20260323042510.3331778-6-paul@paul-moore.com>
In-Reply-To: <20260323042510.3331778-6-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 17:06:40 -0400
X-Gm-Features: AaiRm51oMol5rD-3lC5JmUxYQEOgP29lPad5MhWEYDTptj6N_TPcJrob_X8Dy0s
Message-ID: <CAHC9VhQJcuA0VTpGSD0-x+Z5a__SQBiYfwc9zWwLMDa6THfKPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2966-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6B7162FD93F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:25=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
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
> ---
>  security/selinux/hooks.c          | 252 ++++++++++++++++++++++--------
>  security/selinux/include/objsec.h |  17 ++
>  2 files changed, 200 insertions(+), 69 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..2a3d524dce24 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1745,6 +1745,60 @@ static inline int file_path_has_perm(const struct =
cred *cred,
>  static int bpf_fd_pass(const struct file *file, u32 sid);
>  #endif
>
> +static int __file_has_perm(bool bf_user_file, const struct cred *cred,
> +                          const struct file *file, u32 av)
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
> +                       return -EPERM;

Based on other code paths, we should return -EIO here.  I've updated
the patch, but I'm holding off on posting another version for a day or
so in case anyone else is able to take a look.

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

--=20
paul-moore.com

