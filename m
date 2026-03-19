Return-Path: <linux-erofs+bounces-2855-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGIIFV4NvGkirwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2855-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 15:51:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A956D2CD2EB
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 15:51:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc7tK3fjZz2ynn;
	Fri, 20 Mar 2026 01:51:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773931865;
	cv=pass; b=EED1XnK1CETDBmmar22MLkvP3LmHlVDDI558CRlvx7sIVKuzazpxWZhFG2RaB+d5/48FhTuy6chwAlHOw8bhxj45W1aU5Djr53ISj6NBk3mBKpurQgb5oN1epXZz/08i8bQQiC+q6p+Wb+suMmMzVumU/KQHdmJLGCz4/V3HywfA+NlnvlE/QHr1b6LccZln/KY0bvK0tINIxOyodCPcfn8jGFjkDFECIrw3po2VgYR1aU2zjB2gPe2BarbKBZXfP+e9RelljBrhCXdIXNN8MyUNbVucR4sEs/pKihtgLn1tpRfB0UwN1XA48xg04ivAtjwdbvgu8BXdDSIw7PX8XA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773931865; c=relaxed/relaxed;
	bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djs7tkL+pyXxrIY+XcFn5UyozBtT3Vtg/lGEKTXedQYYYSUmLBDfAaUZBXYF71blCdt/awlP060iHLYrWhA9A6efy4y25Ltn0Ucy+7z1N0csHOKCA2O6Yq/1OPjHAWLjSOOjURrC7YzgyC4EXpHyCOMU5nXsgycFVn64kKnL+8KQJI9vMlbnyyA52DX/+DZOiV5+4tlCYGbMOZFWA4IxGnw1qBEW3InSQxWK0Qz2tYur3/cTrZX6T2nq29N8fwzDilX31afodIBFOz48mpmrqs38Ndx/iL9q/ihnU0QDb2DYM20BCv4MMStfT/428pcKwQeAXGXOInlvp9JocPMHQg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aewBAvAl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aewBAvAl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc7tG5wQDz2yng
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 01:51:01 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b96d784828bso142722966b.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 07:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773931856; cv=none;
        d=google.com; s=arc-20240605;
        b=NWiJzocwFwzMQwr3J2Mhay4hQnslgAzCV8DNmHFzqrN5LXQ8pfAL0G9cdNMJGMz22w
         SEQNZyj2kEEVeHP+DGrVhdfCoiOhMPYNAmGU1rp6ny/exMqbgfubkkvSkXn8uUfPc5Kh
         qLYwzYpqVFkdZGV5cCwXneCS/GaAoSCL5cPVHcs/sfwdH2TGi7i4JX60bqMpc/FnSb2h
         jsG1UOKjYI8vQwqDR0LMPgMdhC98cdeS4yWBxO6pKnNNWIz8otK1cJjvYyv2QiF6vNby
         mODiYYWNK4DPA3Bmyw1yTRWABUfACpxc1InMGdoKq1kODVEQD5fYqJrK5pAP59A/njWy
         3nwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        fh=i8nOosjGpX0JpXxFSK2nGFxrriA0bsjFLc+BgTA+tYE=;
        b=ME0O0gg8TFc8SoJ94y9yUs9l1U/Y5yoGmXQJf0FuGw1eN1CNT6tPPkRxc9ZGYYqnjr
         hcdDkb1NuCpjvP/qY6TQdchYbKYbsAbjvnKvZMAJOMxAtGjsVxnYKmI8Ya0wx+S4OIIK
         IDhzsNLenTY5eumkAuUsqtDrrheoTx3/Ugtv5vUDkC7LPuvZB9n0QJdv+1HDqVlwlnh3
         tNEPdOEl19RMNJl1UVk/g0DMhZzpT3CnB4CI8wQOxFMxiE7RAIzvDza7P2w1UAP/0CW5
         ZVF5VFA2EKg4+Teo2SqXtXjQUlLDUzRcThjir0bepXF1WYs4lkVNQGsgHr4e9G/X8a8i
         OYKg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773931856; x=1774536656; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=aewBAvAlJvuGYKGyd67D2PgVHlIHtM6IWobAQWugKUhMBJzTZlz+tcX7feocXELzx8
         6HtW5828/MOKCbMfWET1zUPezxqlzRSvXCFdw5tsCRWRq9Gb4O4h/Ib+AqGdGszvVm28
         vdomIKIIys+dqx/Xsrks+Ddd3RaGZmaJcHuGfX0yNsfL+oq7ynTzVn/+BdsAx2DJX0ls
         R9t+gVWHs8omf58b0imGeCrUy11pUMdGnsrgrk5YbkYQwEVZYX9fj0YbKVMNjQ7GtGVs
         7Bh/dbhiXC6LStjFDQvZL9Av/Lg2LJJ9G+2/hn2GgtzTIHZgNNMnAIFMKZ+kcvk8ljVe
         cgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931856; x=1774536656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=WkaqlnTWuprnDcSGxQkFBRaplvFXIRaq1+axLAKz5F2IRYEnsPSpDSdMt17OGCKK+a
         Dpmroj7qNGvrZY7jrfr38MicIi6J8tOfFMuALMfKyFEmlCbulRS42iWf9BJjBbjubrFA
         dN3dnpaTJ/xFNdG4JNJr62ieLr6CoQxV2c8LrARWJwtAcizdO8986vEfa0yzt+b68wNp
         6QZGfrdpVFOp1JBXeefsPR4l3btEBI6bhwEAuCRuQQriacEdCQ5E75pMSbbydVuE+Mmj
         J5xP4/z3ej6kIviyeaNF8q3rz9MfpJbNj71yI0aKorEn/bHlGTcWUhXUh4sW2CadTHC0
         OMug==
X-Forwarded-Encrypted: i=1; AJvYcCVNE9K4MMeeN8LgX9pw9KgfsLeKuEjO55FRJ7c6HikzBW5FK56Hs/Q62XVv8jY16UHTqticvF7S9gOzpw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8UQDOIyPrqVVK8aEEby+xsYqKGSS3Us42QuORTBSAI7tmBtD1
	VppKNWvCLsvWV/8A0nlWtNWxI6vcHzTsjXiTfcCPdgVX1UjfQbcnG81W4JCE/x5QZDVs22zvxdt
	ZInr3NXaWpwybfCX2js0RHA/r4Litz40=
X-Gm-Gg: ATEYQzy829rubn7eoRaFKNZb/0UPLlX/Jcicijxk5c3RGPePA0Rx40lN+eJ7ha0muEa
	XddniXknyVUkjl1KO5cSVwW3w1wbwkHaevu5vahoisccCJQO3A1tyPKFZWZTtC3Sc7FmT5vR+HQ
	6mi4vX7jFC6ANVW3E/qhFtSn3MmFNcXIfGVuh9eIGcrkK4Irgy0SLMx0etF6pU4EgSTapE4ZfMl
	b70VkaQe0HfEyZKQz/CJB6SdVQAbqT5iWi7yjEqoQYgozmWiFnS1lWkEnKRDAURRp2t4Xe/Cjq6
	DMbbu8d7TwpjwkdXDxkOIQNI1LtPWZdf21PM9XIRA2O2p2S6zVpC
X-Received: by 2002:a17:907:1b06:b0:b97:aea3:86dc with SMTP id
 a640c23a62f3a-b97f48e0c86mr555307866b.15.1773931856096; Thu, 19 Mar 2026
 07:50:56 -0700 (PDT)
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
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
In-Reply-To: <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:50:44 +0100
X-Gm-Features: AaiRm50Tod8HscrjlQUl55658cqI4Ii7lNI4-xMEI5BRod0xGVsfCDlxh5_S6TI
Message-ID: <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Gao Xiang <xiang@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2855-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:paul@paul-moore.com,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.984];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,syzkaller.appspot.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A956D2CD2EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH file=
.
> > Skip setting them for O_PATH file, so that the O_PATH file could be
> > opened with a negative dentry.
> >
> > This is not something that a user should be able to do, but vfs code,
> > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > before instantiating the dentry.
> >
> > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > This patch fixes the syzbot report [1] that the
> > backing_file_user_path_file() patch [2] introduces.
> >
> > This is not the only possible fix, but it is the cleanest one IMO.
> > There is a small risk in introducing a state of an O_PATH file with
> > NULL f_inode, but I (and the bots that I asked) did not find any
> > obvious risk in this state.
> >
> > Note that specifically, the user path inode is accessed via d_inode()
> > and not via file_inode(), which makes this safe for file_user_inode()
> > callers.
> >
> > BTW, I missed this regression with the original patch because I
> > only ran the quick overlayfs sanity test.
> >
> > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > test case is covered and that the bug is detected.
> >
> > WDYT?
> >
> > Thanks,
> > Amir.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir=
73il@gmail.com/
> >
> >  fs/open.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index 91f1139591abe..2004a8c0d9c97 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> >
> >       path_get(&f->f_path);
> >       f->f_inode =3D inode;
> > -     f->f_mapping =3D inode->i_mapping;
> > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > -     f->f_sb_err =3D file_sample_sb_err(f);
> >
> >       if (unlikely(f->f_flags & O_PATH)) {
> >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> >               return 0;
> >       }
> >
> > +     f->f_mapping =3D inode->i_mapping;
> > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > +     f->f_sb_err =3D file_sample_sb_err(f);
> > +
> >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ) {
> >               i_readcount_inc(inode);
> >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode=
)) {
>
> I think this is really ugly and I'm really unhappy that we should adjust
> initialization of generic vfs code for this. My preference is to push
> the pain into the backing file stuff. And my ultimate preference is for
> this backing file stuff to be removed again for a simple struct path.
> We're working around some more fundamental cleanup here imho.

Fair enough, we can rip the entire thing from vfs if you don't like it.
The user path file can be opened and stored internally by selinux
without adding all the associated risks in vfs.

Paul,

Please see compile tested code at:
https://github.com/amir73il/linux/commits/user_path_file/

Feel free to use my patch as is or reorder/squash/rebase as you see fit.
Feel free to attribute my contribution any way you see fit, just pls cc me =
for
review when you post v2.

Thanks,
Amir.

