Return-Path: <linux-erofs+bounces-1464-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA5C95BBD
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 06:52:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKY2c2sQNz2ypW;
	Mon, 01 Dec 2025 16:52:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764568344;
	cv=none; b=GHKSMv+D64mxMUMT9eJb1BE6XDGr6t6wReSRGyMn4K5pqI27VHjvm4eTXQkf31VeLLwP0mRpviQlwGMTFmrnra2RbPh7VvtAbS9EdtOF1unxM/7E39W3uMJ691EH6ArgFNnkC3CGqyZY3qN1SREuHuYJMe5V0BFHDn7VqLIRgbAFXR9Td16E+qh0ltEuO80Da6HojLmslLf1tbitddu0fSYtyUQWai9hHZZ0HnC6HhjjVuq0atc4dC4+Y43x/lvweTJUPQVa+aTE/BiSYwef4GZ36oj6qLxQ75NQMglYrTnC6hu4RmtRzItFMfo0zlOpMcP8YIiWPUKUFA+g9MMxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764568344; c=relaxed/relaxed;
	bh=DOg9S3K+bAsPOZ2YXaqQC0nyVEL0bJ7nL5/KFBzuUyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyXINcdsQv3MCPgrICuc89Lzd5Fx3MSYHy1GgEcA68WBLIjv79pW+2bU+ueuA6x8clQqQbs0ROU5jWmQSr3X0pKrht/DSdHVl1++RdWcZcFUflPsuAywAqwdsFSzQaPElUfu+rQeN85p9OxcjuqZrjvS4fuy/C1WHDCNmZtEzB358jDYOh+YPxTQ6SpZT9DtPvI3tY0QclQcBGrnYRL/yeKrd3ZhGY1ejrsA4c1EtGP/8owhJ2Q9zWa3hn7/2eTpvb7dnv4VRxqHeSmQC+zNC0UVtigBGQY2Zi6/UngV5QG6G4jfi69HKHgG/3IHcejqe4UOxHnwwccu3T9D0ehNxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QoA9b8bV; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QoA9b8bV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKY2Z5mQqz2yN2
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 16:52:21 +1100 (AEDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-3e84d56c4b8so2463256fac.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Nov 2025 21:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764568337; x=1765173137; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOg9S3K+bAsPOZ2YXaqQC0nyVEL0bJ7nL5/KFBzuUyM=;
        b=QoA9b8bVS/8rjk8NBXoCrvUqGtaRf1pfXZoMBz8f4Q+gc1cO7x0T6PmTQsSOxTz/wV
         HpOuvnj+J1Q4K0OzKTbHaNV+wGdmscrRLCVJk8PhdYuDA28pyGaeki2nrDKUxbHJfa+9
         r67/dZK+h23F3g1wTRADibk2CJ52VI6J98oef7Mv7yAspNUrcIhSLNZoQgf9W1sQqTCM
         VPlvXpGdMtXF+RFTweM3w3yamVogn2QE8zP4K83RTmTXolhPfvt7uYWRzklKTUO02mWo
         KX52L7K3cUECueCxGp+Y35Evr1/TM4uCOJe87W3O2WysLweKh7AcizizNFSTD4HVKBIT
         f/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764568337; x=1765173137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOg9S3K+bAsPOZ2YXaqQC0nyVEL0bJ7nL5/KFBzuUyM=;
        b=ZEOArq4RWqV58AAKNVjqVbb3hOwk71CUN+qdjd2/kDr06qTGbSZzgpgIpJErKCcLkS
         7vMlBfIAX8fw0PQnTvrt6ZY5Xwv0UGTzyAcxA2Md7RI1WqphzzZJ5Z0QiiAvmL+SgRXa
         Tq6lNzpo4sqMTKdfyPclwnjhd7/r7b7JqCD5DzdAvNBNGgPk/cahm+oWzXVF+ggqp1DZ
         Z9l/cp0W5P0ta7H0GYmEJH8nd2JJTohjHd9JnIgQ0MA2E9+9tfBc3gFj1G6MWZxfUmzA
         Dq3eWwDmkkEisB+jvP/F8P+WjTXKV91W4zSKZ5O4FWVt/fm1HI88H3pBIX8WruWUTde/
         fHgg==
X-Gm-Message-State: AOJu0YyUAdilP52D171fQ4c7U0jDrLXvfu2eZFYPzpFM/HLGl9qmsoaM
	FaC/SY1k9xaJTRZwZQdHXw429izC0KhWWaFSIUxYoMqjymDT59LvyBhK0H3pW3kazvVbHxbCDIy
	zvcMEjLOUDc34NZCVVJiDLQGgNV3pKIc=
X-Gm-Gg: ASbGnct7cV5L4dYiQfSH7Yh4XWhhhcqBqjw6VvpRtYNkO84bIn2sLCDWuzL+sGlQWtq
	SJBAtwh3loqZ5MO2VNSVVn1EAQAJ1Zdxgw8ZhbyEhOeqjsWVJULZjZmjLzAlfN5YaAlAYORjMHl
	MV/vzPigqgC/j5STOnqoIXo6KLHURfNZ5Pga14BNzwSYy8PR4AHHPMfd6KUTIqQY/tSAAXwOXgd
	izxbR7EydtOnwHK9H3NkGAl8v2JIUTEpRMy5XJWDuugwxDDg2G45AGS1OOO9GLbXEYYy9NT
X-Google-Smtp-Source: AGHT+IEBLjz6pKtEw7DNpSuupD+5s6YRMjSM31cB+SPUsdfWzObIb+7S/qnM2ngadm23yenOGc+PB5NV33Dhf2jgZPI=
X-Received: by 2002:a05:6870:8814:b0:3ec:3d84:3c5a with SMTP id
 586e51a60fabf-3ed1fdead99mr10890573fac.45.1764568337597; Sun, 30 Nov 2025
 21:52:17 -0800 (PST)
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
References: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20251201023816.1045273-1-hsiangkao@linux.alibaba.com>
From: Jianan Huang <jnhuang95@gmail.com>
Date: Mon, 1 Dec 2025 13:52:04 +0800
X-Gm-Features: AWmQ_blRgaxgAWvQYFXAyvyAmNnlveDBX9YquywZrWIZVVra-9qkckAZ48Q-tHw
Message-ID: <CAJfKizpuGtho2Zw6MPOYp3r1BTPMVy+AN1BxPgbPK=d2nUPg2g@mail.gmail.com>
Subject: Re: [PATCH] erofs: switch on-disk header `erofs_fs.h` to MIT license
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Acked-by: Jianan Huang <jnhuang95@gmail.com>

Thanks,
Jianan


Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=B8=80 10:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Switch to the permissive MIT license to make the EROFS on-disk format
> more interoperable across various use cases.
>
> It was previously recommended by the Composefs folks, for example:
> https://github.com/composefs/composefs/pull/216#discussion_r1356409501
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/erofs_fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 3d5738f80072..e24268acdd62 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> +/* SPDX-License-Identifier: MIT */
>  /*
>   * EROFS (Enhanced ROM File System) on-disk format definition
>   *
> --
> 2.43.5
>
>

