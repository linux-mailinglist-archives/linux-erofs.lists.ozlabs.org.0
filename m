Return-Path: <linux-erofs+bounces-95-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 73664A68C57
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 13:04:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHnSd6mmxz2yyJ;
	Wed, 19 Mar 2025 23:04:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742385873;
	cv=none; b=GHWYKMGbBcsmY7HpJz0cZu4qUujRZ/PhTr3TM+bDH0j9HnMNURnEBhEtV7+vE0CsT0nBziTTAsrcJ/AnICraaQS5eSyUjVGQdy3qz3x8zD/u7JWT/SaLewiAfaJysk79qwepLwU0tj4/kjQGVEK00jcjIsVGplPDfbrtTK7foZq0ZUp46Sj253SaU3OWiGUSSTNS8FcI+fVuvRCGj28v/8HaxjlTh36anqjH2lwHLSMoohRN5JtcslB6kOjaBM+RLZOl2vogyhp4OrBc9OsLaWNmRwTrMbnhqFDFpKTaw46xLpTFKVSALpyoIIM1Ah/p2U2CblKGxqvgh8KBSR1EPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742385873; c=relaxed/relaxed;
	bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf2SKb5kWsuehpFMx6hdRINM7Aaxe8oRzfl44CIjYZ+Hdg17NS6MbOL1U299QLRRyLla0Jk7TqeWZioguLYDE3onEi/H+EZkx0hpN6hhMerQHnvC3BsSiA4PGoA1XaJlql0eM7OGo3XPKwptn6fgyuDEWpwLu3RbBjoHt+97TugdXbOShWtO7cVQMAmoWJR1wdRBhrHpF6IU8ScKeZvv3yvCr/Y+qcmqABOQ6clg2rlMdVE0YL9Jv51a5fCQqGcxqirRd74/kNTN6O4eNi93EUTQgpKeBf5tHnJWoGl39bOAHM3xa2cOvzYynv5bZcEw9yMgSXsIYd57ucfeEayatA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nH5gzdhY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=mjguzik@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nH5gzdhY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=mjguzik@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHnSc42Bdz2xCd
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 23:04:31 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so3148444a12.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742385867; x=1742990667; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
        b=nH5gzdhYW5dEg8udV1Q+ms6rQ0rth+kSpE/YiC3NchX5GxyKolPaNnbyet7ILgSLNG
         VBgzhDkJj4OwA1tHP6ajxFWs4H5cmFRy48eJYVHyujIPgdNsrv9oyabjmwB1wZpCFpxU
         ZyaBpOOPN5j1F6W+LfTMIICGdHXfDo8PX0RSCQxaCV83F0nbKPNlj0gvGagBe1w/SBC1
         2GURCvVF1ODvPI8JGQncSuZhhQzkm1WvNktgPLD6Fjy7CXDxhvgzCkvssKqq9PpVc+w0
         AO2UpjV5csf29OQiTHOtUhFlbJJzoT6EPUdoI/xJ8qHyS2FI675f3gfB60jx8QoGzaO7
         Rmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385867; x=1742990667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
        b=BEsj0dka8rxzMP2c6r0ZCOcJiMmHBuQPks/08o8yav1dQdMXaYK7JkFP20ODTia3gY
         g0Ewnuhr6OaTJaqP6sQmTP3JO3lYtMz5PUtC/L+uKqXaykxJMANHyws3aTThR/MUmWF7
         AnDzQ1+m1yRBuOP/nvkIxbMLKEDRSkye/xF5JP1ZQ8rK9QjOEx2EQOo751HEtXAMxFrg
         86dV7iNUoXSL/FmNXdiGkEiOhFBBBBoOhdlDny1/KaXSO8R/aaO5PtcqfuBMUSf1hn97
         MTM/xsAgynN560hWwriDqAnIFhWpz/Hyq3dhwGe0QpYnoFBwoh5gOwVHcB+Mriudm+fd
         t8yw==
X-Forwarded-Encrypted: i=1; AJvYcCXGaSb0uoNdWDfugEKW9q4aYxCfnxN5tTMTRnl/f0wygFo7jzXR/rO2jSLER5OSSsaOLDhGnJ4CfiubLg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywn1anLxsTYOnYWCoydcEv1tA15tycivDWD3+CEzDKBTzNcbGKf
	e+QM39SvuRJGYkTpwXQFYNd4uTJvn0U4j9zDhgjLO4Lil3vIGaJWQ0AwwrwC5t2OlJAFhuRoWcK
	0opalgNlL1L85bZbi1+eFH8KwNew=
X-Gm-Gg: ASbGncuR6OAzgF7RQ/XyO+G6XKA0aY3MaBr0zM+qxixpHUJdCK6qZ8ZXNJ3YVPYo11g
	1v/3aW0ghR+WVMeoPambebyH5o9e23T+54vEb45LLrAFrRX/ujGZ3xee+6+qpmmVDfykc35VaN+
	k/mhC9ddtsRL4GBjEFj7Y6pL9iQXgw3MhZwFNE
X-Google-Smtp-Source: AGHT+IG6PF4ZQtoeh6iicrqQsCPPEvyzdAtYtZscAoUXBB+3C5gG7BWG47ZdqLIy50KcE4Lgbg4+Hv6J9EZax4UGhr4=
X-Received: by 2002:a05:6402:1ed3:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-5eb80d06482mr2849727a12.6.1742385866463; Wed, 19 Mar 2025
 05:04:26 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de>
 <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
 <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com> <20250319062923.GA23686@lst.de>
In-Reply-To: <20250319062923.GA23686@lst.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Mar 2025 13:04:14 +0100
X-Gm-Features: AQ5f1JqADt1B5Vnfp9K-CCKF_SgF_2UO8WraUUYZPvq8yjlFO1pbUd0LcklvaxU
Message-ID: <CAGudoHHVd8twoP5VsZkkW_V45X+i7rrApZctW=HGakM9tcnyHA@mail.gmail.com>
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Mar 19, 2025 at 7:29=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Mar 18, 2025 at 04:51:27PM +0100, Mateusz Guzik wrote:
> > fwiw I confirmed clang does *not* have the problem, I don't know about =
gcc 14.
> >
> > Maybe I'll get around to testing it, but first I'm gonna need to carve
> > out the custom asm into a standalone testcase.
> >
> > Regardless, 13 suffering the problem is imo a good enough reason to
> > whack the change.
>
> Reverting a change because a specific compiler generates sligtly worse
> code without even showing it has any real life impact feels like I'm
> missing something important.
>

The change is cosmetic and has an unintended impact on code gen, which
imo already puts a question mark on it.

Neither the change itself nor the resulting impact are of note and in
that case I would err on just not including it for the time being, but
that's just my $0.03.
--=20
Mateusz Guzik <mjguzik gmail.com>

