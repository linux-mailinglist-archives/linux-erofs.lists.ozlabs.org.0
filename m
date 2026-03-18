Return-Path: <linux-erofs+bounces-2830-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIUACW6VumnSXgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2830-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 13:07:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01452BB3B5
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 13:07:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbSHZ2j80z2ygd;
	Wed, 18 Mar 2026 23:07:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::629" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773835626;
	cv=pass; b=LBerNDAuK+pyl9FI3jTdh9LB+hl4pPlFl9hpOxIg7okg9qDULrYWOvMwAJypFO0M/7Gbj5iprWwGJgebcF8S9BPAC1Xzq2ItUHw36WTEeTv6rVT2lSFIEzUvE0FLw6bEz6KnDh/42QYcOWYQNsuOOdxxIGd3mFZA31SlWsLpdgkr5TPG+pgIX0pTVjGJOmR7tz7tPkswEjMquB7UqkAxI6wkiMBsnvxo1GKw8DFYByEJv7XVtPDvg1mBLFUBmapds1ldtZGS+pIONvXSBHzFWZMQoDvllU//RBsRlCM/y77DeRfBPTJCWmjIvqfgtFXnzD0nR/Q/LlcpqmIdeVrQJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773835626; c=relaxed/relaxed;
	bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwGj7DIhy00C26IQ/jjSH959IOPzcbTgd4SExNUnPgmZeTNbLdobVHJ01J45TWzbG27Jy/EC9Ve/EENnfxtXo5mGRrjyI1m0m7ThEJipvZY8TWrJid7a64NRtO3RVNcbUqWz/1v/MSxdGfPy2dNW4vE0juEOphJXBM7vfYhHNuMG5xEz/5wJtiV+vi7YOJdiwx8ECsL+2bY5RuK6z3wdUN0hGx5X7JL2U1cKRKcKSKl7wJMwmU+f7X62ZrozNFPMTN0sxTIWkzt2J7e3fqE9gZbXCZUJ7zWDHRZTRYkjnE9khgzjY4ynKSPJTPIoHTghqZv+KdEg+Tmc4vYEePY+IA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ePTPLh7l; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ePTPLh7l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbSHX6ZB5z2xdL
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 23:07:04 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b9793fa5371so533578966b.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 05:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773835621; cv=none;
        d=google.com; s=arc-20240605;
        b=MlQTQqEN6EOnPQhYgZMHGVgAnpxmCtk7RjqKTXVx06p+hVmCn9OSqmj7jCSr1iincs
         upOurKf0fXkUqajhMqzCAJPAi7Zth3PmVjeNamCV6WwIm++S11/vQf6GwNK4BPeW4GVh
         f5PVDHgzYjxuTJdZbkYvKUTl7fDnecYOFxqv/EKEnZn6DlVwgGprepJQXiItcG1pHtQ6
         m3VnJ88DPvx592jGovzL5DUiITLixInlHRqxBpzh/9vkzMCcomrPhFyCJ61saQGNhh0m
         vSGCyjmDlSAlCvDe+lubTiURK1klr3PscqB7nMigxmAJppTZOiG/+FKk8nafpf6adDKq
         re6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        fh=KVI3B1OWmW93mzAIbb1/hzaUdbM7KzDsMIdnOJ+T2IE=;
        b=d3NQBx2S++8JgSh2sc6bvCOMngGp6UVSr7ykiefnziMjGK0oszCAJgTwXvAwn4rlAi
         A2SZYgShXd2MCImjgBhHSnAbg3wUFasRJXC6vRsrk463IWzSX3ajL01sasv7udzYo7sf
         N9Vgw9NeA9LAMa92eOBjjoQwfxZQfEjY+ceLIZIDSPIMCWOtr++ISpNGOi+0R1KhIAq0
         dMupvtKQ8+RnAfLclmdyofglVjqomG9sMkF0gPBqpGv9/CVkIPqwfGe7nB+grrZdIfo0
         cqUgP8YnxbEgFjdrcGgF1HpGZNW9euOowfJZujyQEkcNqTLEQE5fzGEkxhjrzFqKoDy5
         hN2w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773835621; x=1774440421; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        b=ePTPLh7leyaP6ME73oWnwVGZF5MTE1ByzMjeGCFFoIwH8pFD3MR2+wK7Cw9u48z7VG
         0MAxpkkMgcgXwYObgKS8ozRlE+9K+O4t6l/JWUrJJJN9hzP+tj3CuwPOzNXRs8xTkKJQ
         ibX4jtDVvFRvtsEV0t3wtQmGdeoldw0lzp6CB2e8hxz9vaVI7Wqbe5ZIx7UmZ8D73n5K
         3syjpS07Ele5mF2cZUCtpQcBkkYxr5XjbjXYl9nd6LNrNDK76fMIpZStD2feyti3mCpR
         prZEqYNRPGEeKytMJPG9BuDX3AFBaZqqfBnIbOKUDFQOT5L7cYbJeYWzHb5U8UFuNnqR
         ezlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773835621; x=1774440421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZDbD4STVvyzkKpqwhxvWWUwBKgUQKeGSzEwSkv9W2c=;
        b=WpWgOZpZGTnhSLIR5iTaA+nSoGg7gb/yxgMr8TO5/ulbFV/OQKXc+UIBnpCqa3hqCZ
         eI78Fij4ia6w0aStZJQ06kkQf+mOiHkZ6yonRPQVio6CHHMns3wIa/pRJugTL2a6Wt2v
         Tnwyt1usD9ttZd+g2kJ9r3VCHAImfLLnGkQWW3zUxCO7XMxx0X8dPY1XZ6JcSWKZZGXv
         HYU69PebLMzgp0nBZHsc1q4ZdW3AoqB7Geo6+fMrgggmhYdrQbs+1DsxIN975YVwjeNV
         /0wvG5pKw/RxrkBTuPYChwr8E/VRJp060iuxGSPCszRjpnJDKAysJKXxsb0ITVZTl+d2
         0Zow==
X-Forwarded-Encrypted: i=1; AJvYcCUcxPxXF+uI+K307GMLm0/OKqnfB1gLNpP2i8k2XMI3GoLf13uePb8HZZUJuRs5V+FvxyI6Evv9jVFMXw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzgtAUT7+n4oOUYDAGFR+MFT6p7s+YdzWlqiLGaaAkbiBEFUp5J
	uevgJHj+7Z1McCgnZshFrowvjxypqr2qOoR5SH9iUiNetikkSO6g3ePO9Wc+4T/KCEDjARQ+Kvo
	NGn9Cy/uQSPdhu8fAzNWRRp5+63C10+U=
X-Gm-Gg: ATEYQzwACaMR7CX0CMdqvB/Jh/lV9IV4SdboFRA7+I2rkaO8JQxiNemcbpbnFBGqYVQ
	7XZi0DcmpME7hXxamn4P3Bosq2PUYZ5k5RSI/pVZkBiQBm3tHhuv15hGp05Mryb7xsmdwk2eCcF
	lXZLUQTkQXzh3TrwwhdBJ40WkL1feevu9ba8gsEefwUwGBqgpNyiK+SVDNb1HKpGJa71AOGuDm6
	o/0TAW+2H9m7UMSX7jUSqWMAWLhQIY0mismI58hYV0FzGkKGdID9X8t2cskQ+FrOrPT+KpPqzqq
	kZCYAOrmTitjcn/eVLD6AvKIUqKJ90nkfz6toCSOSURQIy6UdeQ=
X-Received: by 2002:a17:906:6a01:b0:b97:fe6d:2e4a with SMTP id
 a640c23a62f3a-b97fe6d3a3fmr112673966b.10.1773835620414; Wed, 18 Mar 2026
 05:07:00 -0700 (PDT)
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
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-6-paul@paul-moore.com>
 <20260318-einsam-sellerie-2d547dd338ee@brauner>
In-Reply-To: <20260318-einsam-sellerie-2d547dd338ee@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Mar 2026 13:06:48 +0100
X-Gm-Features: AaiRm52zvCWb40EW5edB_L-EubZhlbZT4WB8o_i5sTfBey92Yh1WyoQQt0_imPE
Message-ID: <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] backing_file: store user_path_file
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2830-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,paul-moore.com:email,mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: F01452BB3B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:57=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Mar 16, 2026 at 05:35:56PM -0400, Paul Moore wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > Instead of storing the user_path, store an O_PATH file for the
> > user_path with the original user file creds and a security context.
> >
> > The user_path_file is only exported as a const pointer and its refcnt
> > is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> >
> > The only caller of file_ref_init() is now open coded, so the helper
> > is removed.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
> > Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/backing-file.c            | 20 ++++++++------
> >  fs/erofs/ishare.c            |  6 ++--
> >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
> >  fs/fuse/passthrough.c        |  3 +-
> >  fs/internal.h                |  5 ++--
> >  fs/overlayfs/dir.c           |  3 +-
> >  fs/overlayfs/file.c          |  1 +
> >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> >  include/linux/file_ref.h     | 10 -------
> >  9 files changed, 90 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > index 45da8600d564..acabeea7efff 100644
> > --- a/fs/backing-file.c
> > +++ b/fs/backing-file.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/backing-file.h>
> >  #include <linux/splice.h>
> > +#include <linux/uio.h>
> >  #include <linux/mm.h>
> >
> >  #include "internal.h"
> > @@ -18,9 +19,10 @@
> >  /**
> >   * backing_file_open - open a backing file for kernel internal use
> >   * @user_path:       path that the user reuqested to open
> > + * @user_cred:       credentials that the user used for open
> >   * @flags:   open flags
> >   * @real_path:       path of the backing file
> > - * @cred:    credentials for open
> > + * @cred:    credentials for open of the backing file
> >   *
> >   * Open a backing file for a stackable filesystem (e.g., overlayfs).
> >   * @user_path may be on the stackable filesystem and @real_path on the
> > @@ -29,19 +31,19 @@
> >   * returned file into a container structure that also stores the stack=
ed
> >   * file's path, which can be retrieved using backing_file_user_path().
> >   */
> > -struct file *backing_file_open(const struct path *user_path, int flags=
,
> > +struct file *backing_file_open(const struct path *user_path,
> > +                            const struct cred *user_cred, int flags,
> >                              const struct path *real_path,
> >                              const struct cred *cred)
> >  {
> >       struct file *f;
> >       int error;
> >
> > -     f =3D alloc_empty_backing_file(flags, cred);
> > +     f =3D alloc_empty_backing_file(flags, cred, user_cred);
> >       if (IS_ERR(f))
> >               return f;
> >
> > -     path_get(user_path);
> > -     backing_file_set_user_path(f, user_path);
> > +     backing_file_open_user_path(f, user_path);
> >       error =3D vfs_open(real_path, f);
> >       if (error) {
> >               fput(f);
> > @@ -52,7 +54,8 @@ struct file *backing_file_open(const struct path *use=
r_path, int flags,
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_open);
> >
> > -struct file *backing_tmpfile_open(const struct path *user_path, int fl=
ags,
> > +struct file *backing_tmpfile_open(const struct path *user_path,
> > +                               const struct cred *user_cred, int flags=
,
> >                                 const struct path *real_parentpath,
> >                                 umode_t mode, const struct cred *cred)
> >  {
> > @@ -60,12 +63,11 @@ struct file *backing_tmpfile_open(const struct path=
 *user_path, int flags,
> >       struct file *f;
> >       int error;
> >
> > -     f =3D alloc_empty_backing_file(flags, cred);
> > +     f =3D alloc_empty_backing_file(flags, cred, user_cred);
> >       if (IS_ERR(f))
> >               return f;
> >
> > -     path_get(user_path);
> > -     backing_file_set_user_path(f, user_path);
> > +     backing_file_open_user_path(f, user_path);
> >       error =3D vfs_tmpfile(real_idmap, real_parentpath, f, mode);
> >       if (error) {
> >               fput(f);
> > diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> > index 829d50d5c717..17a4941d4518 100644
> > --- a/fs/erofs/ishare.c
> > +++ b/fs/erofs/ishare.c
> > @@ -106,15 +106,15 @@ static int erofs_ishare_file_open(struct inode *i=
node, struct file *file)
> >
> >       if (file->f_flags & O_DIRECT)
> >               return -EINVAL;
> > -     realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred());
> > +     realfile =3D alloc_empty_backing_file(O_RDONLY|O_NOATIME, current=
_cred(),
> > +                                         file->f_cred);
> >       if (IS_ERR(realfile))
> >               return PTR_ERR(realfile);
> >       ihold(sharedinode);
> >       realfile->f_op =3D &erofs_file_fops;
> >       realfile->f_inode =3D sharedinode;
> >       realfile->f_mapping =3D sharedinode->i_mapping;
> > -     path_get(&file->f_path);
> > -     backing_file_set_user_path(realfile, &file->f_path);
> > +     backing_file_open_user_path(realfile, &file->f_path);
> >
> >       file_ra_state_init(&realfile->f_ra, file->f_mapping);
> >       realfile->private_data =3D EROFS_I(inode);
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..b7dc94656c44 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/task_work.h>
> >  #include <linux/swap.h>
> >  #include <linux/kmemleak.h>
> > +#include <linux/backing-file.h>
> >
> >  #include <linux/atomic.h>
> >
> > @@ -43,11 +44,11 @@ static struct kmem_cache *bfilp_cachep __ro_after_i=
nit;
> >
> >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> >
> > -/* Container for backing file with optional user path */
> > +/* Container for backing file with optional user path file */
> >  struct backing_file {
> >       struct file file;
> >       union {
> > -             struct path user_path;
> > +             struct file user_path_file;
> >               freeptr_t bf_freeptr;
> >       };
> >  };
> > @@ -56,24 +57,44 @@ struct backing_file {
> >
> >  const struct path *backing_file_user_path(const struct file *f)
> >  {
> > -     return &backing_file(f)->user_path;
> > +     return &backing_file(f)->user_path_file.f_path;
> >  }
> >  EXPORT_SYMBOL_GPL(backing_file_user_path);
> >
> > -void backing_file_set_user_path(struct file *f, const struct path *pat=
h)
> > +const struct file *backing_file_user_path_file(const struct file *f)
> >  {
> > -     backing_file(f)->user_path =3D *path;
> > +     return &backing_file(f)->user_path_file;
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_user_path_file);
> > +
> > +void backing_file_open_user_path(struct file *f, const struct path *pa=
th)
>
> I think this is a bad idea. This should return an error but still
> WARN_ON(). Just make callers handle that error just like we do
> everywhere else.

OK.

>
> > +{
> > +     /* open an O_PATH file to reference the user path - cannot fail *=
/
> > +     WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> > +}
> > +EXPORT_SYMBOL_GPL(backing_file_open_user_path);
> > +
> > +static void destroy_file(struct file *f)
> > +{
> > +     security_file_free(f);
> > +     put_cred(f->f_cred);
>
> Note that calling destroy_file() in this way bypasses
> security_file_release(). Presumably this doesn't matter because no LSM
> does a security_alloc_file() for this but it adds a nother wrinkly into
> the cleanup path.
>

This is for Paul to comment on.
The way I see it, security_file_open() was not called on the user path file=
,
so no reason to call security_file_release()?

It is very much a possibility that LSM would want to allocate security
context for the user path file during backing_file_mmap, when both files
are available in context, so that later mprotect() will have this stored
information in the user path file security context.

But in this case, wouldn't security_file_free() be enough?

>
> >  }
> > -EXPORT_SYMBOL_GPL(backing_file_set_user_path);
> >
> >  static inline void file_free(struct file *f)
> >  {
> > -     security_file_free(f);
> > +     destroy_file(f);
> >       if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
> >               percpu_counter_dec(&nr_files);
> > -     put_cred(f->f_cred);
> >       if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -             path_put(backing_file_user_path(f));
> > +             struct file *user_path_file =3D &backing_file(f)->user_pa=
th_file;
> > +
> > +             /*
> > +              * no refcount on the user_path_file - they die together,
> > +              * so __fput() is not called for user_path_file. path_put=
()
> > +              * is the only relevant cleanup from __fput().
> > +              */
> > +             destroy_file(user_path_file);
> > +             path_put(&user_path_file->__f_path);
> >               kmem_cache_free(bfilp_cachep, backing_file(f));
> >       } else {
> >               kmem_cache_free(filp_cachep, f);
> > @@ -201,7 +222,7 @@ static int init_file(struct file *f, int flags, con=
st struct cred *cred)
> >        * fget-rcu pattern users need to be able to handle spurious
> >        * refcount bumps we should reinitialize the reused file first.
> >        */
> > -     file_ref_init(&f->f_ref, 1);
> > +     atomic_long_set(&f->f_ref.refcnt, FILE_REF_ONEREF);
>
> No, please don't open-code this. The point is to stop any open-access to
> f_ref. And also below you introduce another atomic_long_set() open-coded
> call as well. Simply adapt file_ref_init() to not do the -1 subtraction
> and use the constants directly.
>

OK.

> >       return 0;
> >  }
> >
> > @@ -290,7 +311,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                   const struct cred *user_cred)
> >  {
> >       struct backing_file *ff;
> >       int error;
> > @@ -305,6 +327,15 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >               return ERR_PTR(error);
> >       }
> >
> > +     error =3D init_file(&ff->user_path_file, O_PATH, user_cred);
> > +     /* user_path_file is not refcounterd - it dies with the backing f=
ile */
> > +     atomic_long_set(&ff->user_path_file.f_ref.refcnt, FILE_REF_DEAD);
>
> Please massage this and send that patch. I'll stuff it into a stable vfs
> branch that both Paul and I can merge. Paul can then send his PR.

Sure. I'll try to send it later today.

Thanks,
Amir.

