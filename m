Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C8A9C223E
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2024 17:37:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XlPkM2lfYz3c1D
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2024 03:37:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731083866;
	cv=none; b=KseB6C69Gy/KjOsjiCHPnGMdHYAkHo0rL2eENtXqaMN5dJlV3pvifFs+NBwgqS0lWoTgHCr0qdp7Yv7whEoFZuoTTCxY48pRh8vJaDJPbTQJpd+319RWUo3fCCpfGLr/0QBpWBxUTv2d50YAUasgSpRqSYyZdBjyrPAe1wOI3sjXQ/avol1CDKwHhWeHNJ2GLCRPfjstZT4wdR1Fd8ppYwHuk3fPu9wCjHKdS8g+7k4cJDSYcfl1KGYoW5YSYMVpg/I27Mir8HLIoE7hcFL8XNr2LOaPxrRMZM0HnYqnm+qhURZv+ic/qWDjXo0uKj8e+QTA7ygpwBuPfS9gbj3hZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731083866; c=relaxed/relaxed;
	bh=IVlyNzICBgbV/3WvXD/iX77w7FzbfcmribMsYtHhU/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VF7irKGaezpfTNW6F55X3gdrfadxLDUH/8wgQwIvW/ZGD6AwP8TGn3i4HTOhU2LTMJ97Yar4iin3KtVYVm9zUd8h0TWdydE5ZX6m7yFST0U5NwhDM8q/amcsJ3yoBvnbQEf8V0Fe4FEZtR49On24hbm4WNm+rSc8Li0tlW79fJRJYWc7n/7tRAzNRg6W5nIpxmuhEcdZTPqvcylIC7ag17Nu/Uewol04qZlga7IYy3o+4Urn4uQKo3C/GlQZKUFrUri2KGnjEh8oQ+/x28T8xQ64jDyB37YnMAJiLfMrDWoLKQRYDtlF3Olzd3OblNlP71Yxoo0/VXTR2WDZTF1K0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mbaynton.com; dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bhLzHFIy; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org) smtp.mailfrom=mbaynton.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mbaynton.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bhLzHFIy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=mbaynton.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XlPkJ3FhNz3bxR
	for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2024 03:37:43 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso1890901a91.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 08 Nov 2024 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbaynton-com.20230601.gappssmtp.com; s=20230601; t=1731083859; x=1731688659; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVlyNzICBgbV/3WvXD/iX77w7FzbfcmribMsYtHhU/M=;
        b=bhLzHFIykBOmdtK1VFxIo0CPYRzPyweaKJgaZF6nu+wmj3npBmnS8Imb0J6YVJrrZ6
         LWj2Sdw3x1DCa/XvnStm/G/0UdBAiNNNOddZdYDEP5T+B/Vzw2Llo4bSJc0ZcVUrH4Pa
         5fbJtuqhs7k6hIhK3GmzjC0rqZ8whuXzjYsT/PmCYVVE9brWhaWpQb6zRbftlVj2Q0+5
         +pyOqAblUDAQEvOoKFAs+2ZPFpWk6Gl/ubjwIFFgDdD2olABZPybWpbD07k3vXTei0EF
         ir2BfyplCSIBUXuN1iVHwzd3fg1Q7wv+QMBe2zISNYEdg+W9YIypk3SfD614OCtvoKEx
         gLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083859; x=1731688659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVlyNzICBgbV/3WvXD/iX77w7FzbfcmribMsYtHhU/M=;
        b=YeYIG2ZhxUN/zBSiOcOWzGZTmD0Lk4I+7H/5O6S5y5LYRIQcwNj7KWj2UiJmXVqqYG
         5W/hSp/6G7dotQcU8o5707ziM91xzYK98ChECzy90R5FpQcWc8VMDyUZXw2gLBFOFG+y
         ccSpJx8IshN0eXrfzqCx430p1M9UE0QIQFeIAzhxFGvsxzaUtN1oYu8XJrvRNzE1rbjW
         yaagtYzdu9ldkmD7Ueoa9j+TiDfurLDZ+L5KAESEywVSn/cuvnwCqygsfkThaH0eOrvt
         FfufEcdyWXRfDDcsQfWKGgT/G9X/QruHBl570K7+ziGYypKBwNthrZbdBEDAudsqejYk
         8YBQ==
X-Gm-Message-State: AOJu0YxujQ2/jn4gGsVOzvVztfpb/n7eh0RzgpHXmVMsrv8GJhg1eEGW
	ZEXh4sIlcMNM7BI1aU+/mApP2o3+S9kleNS4B1L4KppNEEJVhC5YxcAMsdJ5vwu0IFyVHkQook4
	3CtIop+JoF/5obZvM+ErMfhSgMEJ2GvKDrMc3zQ==
X-Google-Smtp-Source: AGHT+IGkqDxiKZQ9Ed8v10wAlcTM26gp/hWOwoCR8dFZfEy0Av49BHE+SWLNsP146+wjqEu6fFQ5qDHSzsrwUe8Vi8c=
X-Received: by 2002:a17:90b:1f8b:b0:2e2:ef25:ed35 with SMTP id
 98e67ed59e1d1-2e9b14d565fmr4381834a91.0.1731083859361; Fri, 08 Nov 2024
 08:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20241024195801.1546336-1-mike@mbaynton.com> <bfbf180e-21d6-45de-b4c9-43089dcef333@linux.alibaba.com>
In-Reply-To: <bfbf180e-21d6-45de-b4c9-43089dcef333@linux.alibaba.com>
From: Mike Baynton <mike@mbaynton.com>
Date: Fri, 8 Nov 2024 10:37:28 -0600
Message-ID: <CAM56kJTuwXoOtQ+V7YHygHhHb--9qUmvkbADOuG=-4zwHvfkzQ@mail.gmail.com>
Subject: Re: [PATCH] mkfs: Fix input offset counting in headerball mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: sam@posit.co, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thanks for the update, Gao! Appreciate your review.

Mike

On Fri, Oct 25, 2024 at 8:36=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Mike,
>
> On 2024/10/25 03:58, Mike Baynton wrote:
> > When using --tar=3Dheaderball, most files included in the headerball ar=
e
> > not included in the EROFS image. mkfs.erofs typically exits prematurely=
,
> > having processed non-USTAR blocks as USTAR and believing they are
> > end-of-archive markers. (Other failure modes are probably also possible
> > if the input stream doesn't look like end-of-archive markers at the
> > locations that are being read.)
> >
> > This is because we lost correct count of bytes that are read from the
> > input stream when in headerball (or ddtaridx) modes. We were assuming t=
hat
> > in these modes no data would be read following the ustar block, but in
> > case of things like PAX headers, lots more data may be read without
> > incrementing tar->offset.
> >
> > This corrects by always incrementing the offset counter, and then
> > decrementing it again in the one case where headerballs differ -
> > regular file data blocks are not present.
> >
> > Signed-off-by: Mike Baynton <mike@mbaynton.com>
>
> Sorry for late reply, I'm busy in personal stuffs now.
> I will look into these cases and reply again later.
>
> Thanks,
> Gao Xiang
