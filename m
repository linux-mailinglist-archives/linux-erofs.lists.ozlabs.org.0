Return-Path: <linux-erofs+bounces-2837-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mODeB4c5u2mJhAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2837-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 00:47:19 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DA2C3E72
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 00:47:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fblqJ56ydz2yYK;
	Thu, 19 Mar 2026 10:47:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773877628;
	cv=pass; b=TwlNZ195iZUooE5jAbKvv6qjRcFxUtfJe7g8NsNOFRsOo8yitQztW2i6utixaNhbN80tR7uegIrSPX2GR73LyQ7B3debpSq/7T6tgE0E4T7xyFL6u59PgERx+I6eKW7Q8QlpxqaHRg3HKkpUFGhurcDz/hzMqFkTKoce0pOG3kWx4S5ML1Pw5BbuvLM1CVWeoJ6b/Ihh0pnmLHAbLhc1q9z/pDlVa6KeXQ4W+gvDT0UewsIfUe+DyHj3wEf8T8d6grb3q+rT6Z4UVHcl2TZpBmGyy/QhHzSiguGFcPF0cKuQ9K3TneYBb/hubmwi++u5SsrUbzM6cxeMvKPcwTYNmw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773877628; c=relaxed/relaxed;
	bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ+tYuJrN47IDjVaAuykLzxfXUTYsXEknbNMgSSPunBO9WNixoOjW9uapgxXJnr5+pcMe8PaP4EduNFAogzbrE8/vmvJhsQGVM56oCbWHn76tkwJ4W4miLaDBes3U7/5uSzqcvvA7KGKDNVXpSz7a5FY5um0hthEpO5ioKqYkybP7c4HO34jC7lM8x03RfYzhJwWoqKgpukwrI7KFCHAashxi1GNbe4s5zuNCMxDGpvTrFjEkhQzTbzazM9ljcTS9ywwCyFERXDDJ/q0Kbt+r2ZfT8bTwh5Fh9qATWUz6UHS4GRRMmGGn9OJi3AjdF5Opdo37Vh4RjeNIC+ic70/xQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BRh2ipJV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BRh2ipJV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fblqH1FwPz2xYk
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 10:47:05 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ad9f316d68so1667635ad.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 16:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773877622; cv=none;
        d=google.com; s=arc-20240605;
        b=T4vjvAoTnSM4mkf+hFQ5DNfkM6L0bdCMoN0ajfFopFrsgUl8xWGvXH8bReiWU5c0bn
         qLOEGxlqjb+W7P80NtvAk/PubAh/eAtI2g6khAfOJFLjtIKxmM+Tjih0hLNfjlSC747w
         dJ9lS9awsJUts8ofHm73ZPMEmO1Lk/qxDp1KPRSXsmNybqS3RlVTwTGe9j3Q31JxGCGg
         PC2AjXGWOF4Y1fbrEyHQOONineuLZ/C8bh3VplUUENGkCHFzMsVH6+JEcc+g4Sd2PV9B
         98Gmz0QjUlUY7xdtrLGZk06RiHd+13phj2dkOAmbt+wQ6BHahE1FB/1VmLRjsEEGj+8D
         FJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        fh=qgEtXe38+sAoSo2KXa6/zOh6p2EgpRpdZGz1r+9TkMA=;
        b=bgB/QQAcfv8pehAGWXp83Yz3mVnmC7ewNpT10IL+LjVm/OUAS4FsG5Xf++s3TxV1Xr
         XDXuChmiscs3h+2VZHuNmYh8r4DSDH4T+2dV1se40x6P/AIxSs8h+LCu3yC6bKfcX9aT
         N/5r9hoKhfKx+88WzHxvIRRsubnDsz8L3Zo53+cJpXt3QwfjtjiFEeCQ+8Y4+kUiEYuT
         RjsHXDKJLR0l3Er4L2sy+6NSOw6MwoK1Frd8NCeJ41ev2/6ddum+OW1DYqnbf/cbPhPq
         0fkx6KE1Aa0ZCXsJ+3DzJubfOjue6ysyGk5MLZjOfQS6WP3ymGdJnn8HsPzxZyGBDRhS
         K67w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773877622; x=1774482422; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=BRh2ipJVPbKMXTL8/JpDghqlcJHlSU45IvCiIXPJwJ2eFH/wSFRDIst+pSHopkD555
         LyYx7Ehywtonr58GoI4Dw/WuA1vQXZ0gVLr0cGtGsLKUGTo7tMxqoB2lT276/uday6sN
         rD5MWQWQqwdMNagnm/z+UxJlG2JeMc0TdESFnTTiLKWkXDdKcHLf4jaxGu2e/mbXn84C
         mE0t+Kn8Ym7XEHZT6+pgc2vMF5GnHlKwNiEoPUGTMZo0TAueStULBEtBE+tGIESomB/N
         ofUU00ybswOn0igvBjzqmVgLtD6NrOfnl7ZSR77CoDIBWLYSjvhaVNQtVKcbrAZ+kVM7
         1w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877622; x=1774482422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=Gwk1UeoU19aOG2cteqVwDSyrmxQ9gGjoBICE5p8k/lGukxEa6+oZQNTlHz7VhLmInL
         Jzxr8Fzdfr3HBRbXO+05uED3tb7p89+MkJHQSc7s+fVFmjuT2NUCacqh1e+ylKQMzPBz
         UIPpCcwPAYrzIIfZczJAdscOhiBp/Wvj6ubQTHLQDryV2OZTMhIbwLbAz3DWoG8WOC1w
         NejU70rBm3z9NnuB6gPbxLhX+FtHtmOdcPBxxZO8Nizaug7JadL+jFCqQJWh1CR//OG0
         10uwrLUqx0yl05nAU74gDmTJFspPYjPm8l/V/jUkt0iON3k4RYirDNy0gPzhJvpI3OIM
         BArA==
X-Forwarded-Encrypted: i=1; AJvYcCXjZh+5l8s2YJVt1LxhVjZjaoXOBPcetNVqCJwPz5eBk8VRwLA7lZGPc96YVNNRFj45zMk09ZT4jvVvpA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwselE1DHI6vEoA0bfee+cGKCAUd6GhSrwNG1DNOPcqKbLvlW4j
	hjT8xZi5t/3eBe7JkgzHtuKlQuSM/p2YFQ2MZzwiid4rn52Q9pjvfBVsND7UB8e0mRSqua/ZjaE
	q2N4eXEHI1dSsFSa9bhsogGWutkFQyIyJlbmF6p79
X-Gm-Gg: ATEYQzxuiFeJf+Ol84blIRHqLpSwo9wdbUUlb+grVEKQpRgJwJ+cTRLDpyRmoppJ5ec
	wVZJTtPohmcR1O5xNZnIePdkKb1qUyOTYoyIq0EI5rXpU6XDSqjo4NqGARx2MP4t2K1nMaA+68K
	3Hj3M039THqb8frorRBUV6bA4ECT0iVvEs0M1tEKU/qfPlwbKzGsevDJUDCXjdVNDECukxy8GCm
	enp1d6J3pQRF29pK0AAJ2DqSyoeY8O0M/1zSnbyAAeFlCV1qpVgrE2pgmBpSW9cmNGF9H69daHG
	wzoYMmQ=
X-Received: by 2002:a17:902:f547:b0:2b0:7177:d5e5 with SMTP id
 d9443c01a7336-2b07177dc04mr35425715ad.43.1773877622532; Wed, 18 Mar 2026
 16:47:02 -0700 (PDT)
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
References: <20260318131258.1457101-1-amir73il@gmail.com>
In-Reply-To: <20260318131258.1457101-1-amir73il@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 19:46:51 -0400
X-Gm-Features: AaiRm50UCF1CurPQjVXbzqdFj4rL7YmqoTti-AfxH9o9diMwAaN1iIjAFrpAzkY
Message-ID: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
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
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:brauner@kernel.org,m:miklos@szeredi.hu,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2837-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A10DA2C3E72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Instead of storing the user_path, store an O_PATH file for the
> user_path with the original user file creds and a security context.
>
> The user_path_file is only exported as a const pointer and its refcnt
> is initialized to FILE_REF_DEAD, because it is not a refcounted object.
>
> The file_ref_init() helper was changed to accept the FILE_REF_ constant
> instead of the fake +1 integer count.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Christian,
>
> My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> Here are the changes you requested.
>
> I removed the ACKs and Tested-by because of the changes.
>
> Thanks,
> Amir.
>
> Changes since v5:
> - Restore file_ref_init() helper without refcnt -1 offset
> - Future proofing errors from backing_file_open_user_path()
>
> [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.com=
/
>
>  fs/backing-file.c            | 26 ++++++++++--------
>  fs/erofs/ishare.c            | 13 +++++++--
>  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
>  fs/fuse/passthrough.c        |  3 +-
>  fs/internal.h                |  5 ++--
>  fs/overlayfs/dir.c           |  3 +-
>  fs/overlayfs/file.c          |  1 +
>  include/linux/backing-file.h | 29 ++++++++++++++++++--
>  include/linux/file_ref.h     |  4 +--
>  9 files changed, 103 insertions(+), 34 deletions(-)

Still works for me.  I'm going to update lsm/stable-7.0 with this
patch so we can get some more linux-next testing.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

