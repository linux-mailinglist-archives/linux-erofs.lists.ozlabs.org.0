Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 026BE902F1F
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 05:29:15 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gtPgCKGs;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VyvKh06xKz3cF4
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jun 2024 13:29:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gtPgCKGs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::b33; helo=mail-yb1-xb33.google.com; envelope-from=keiichiw@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VyvKb0wJMz30W7
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jun 2024 13:29:05 +1000 (AEST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-dfda9ec1917so76598276.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jun 2024 20:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718076542; x=1718681342; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTgYTd6dNUCtFYuIiC/b4mPSmBPiDyor0WbLHT00HQM=;
        b=gtPgCKGsIrLwU5RsQPxlMTvdiX0fHEYbsVr3dxNkmEZ1F9lqq/n3ZARpa0pqJ+rwKt
         R2QFXzWb47/IbOArdp3bPPCKY+Ah8px+xQ9mcrYpKXm3s0XuyrFByr8ij4Fmtsn9HBpq
         vfcch7c788ZmWvo2++HzTMLLuRjnc4p5WmHpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718076542; x=1718681342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTgYTd6dNUCtFYuIiC/b4mPSmBPiDyor0WbLHT00HQM=;
        b=wTUHnG4OS66SWYgRbMJMSg3nj64+Esnpf72Qx3qyuhY8+l/JZ9NqgQyZZBF3PFCgEc
         fTzTUIMfdJgmjRr4OaD1UsICX+TDDn5N5ojPqCO84878sppKv5EYYvKBLvFWrE4s+ymy
         STjqTjFSMXmdrlqzJZKFeUMkGa+v2D59vlvvkjkiGmtbrJ3Bt2CAp9+frg9ikZ0t2krJ
         YxEEmSP9rh2QcXds0BwtziYIitoqIs7t2pHA9ZznkH8ujrETIC4dQ/VkjFL010eswvBp
         3l7IIy5PSYKbvg2ULIz2PcvDZR1uWAO9+ISpmqs1/GOzxCbhGhxM4bL3Y9OU5AcTaDYJ
         cmtw==
X-Gm-Message-State: AOJu0YzoBePhFYjqM2LarphWj3WRpacV+uNDVQp7kj2XIRxxVGtP+EOW
	zUxqELyTZzlGkLuPA/a00yUvs05rTIa4fFqKrtX2bmzv36Iqnkp2vm0/CmvseHShU/e8X975M8Y
	e5H8ohYk8YLzzvvsXwMxuX4HzHAIl2libS+Gp
X-Google-Smtp-Source: AGHT+IFhmRt16cMjfkxb3Burr75YtXtam+6vpD5owIjb0jK9NRzffONDQwXY1PoGdIBKrmhFiE3Tr05Ifun7CY9DGII=
X-Received: by 2002:a25:948:0:b0:dfa:cd11:df34 with SMTP id
 3f1490d57ef6-dfaf670aa96mr9692155276.61.1718076542660; Mon, 10 Jun 2024
 20:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAD90Vcbzx_Qz_V3CLJXHkvEfRX=E3Rkf-nHoTc=NDQPZDesJQw@mail.gmail.com>
 <97816659-1e55-4f5e-9bfd-8927ddea0926@linux.alibaba.com>
In-Reply-To: <97816659-1e55-4f5e-9bfd-8927ddea0926@linux.alibaba.com>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 11 Jun 2024 12:28:50 +0900
Message-ID: <CAD90VcZEkPvJNgJ=MnPEFDyBLbbMLatOtA+NxL_9q23K+CrvEQ@mail.gmail.com>
Subject: Re: Can mkfs.erofs keep specified files uncompressed?
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: sarthakkukreti@google.com, Junichi Uekawa <uekawa@chromium.org>, linux-erofs@lists.ozlabs.org, Jae Hoon Kim <kimjae@chromium.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

That's exactly what I wanted. Thank you so much!

Best regards,
Keiichi

On Tue, Jun 11, 2024 at 12:10=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> Hi Keiichi,
>
> On 2024/6/11 10:58, Keiichi Watanabe wrote:
> > Hi,
> >
> > Is it possible to exclude specific files from compression when running
> > mkfs.erofs?
> > I found The --compress-hints option allows me to specify different
> > algorithms for files thanks to [1]. It would be great if I could
> > specify "uncompress" in the hint file.
>
> I think it's already supported by specifying pclusterblks as 0
> to leave these files uncompressed like:
> 0 0 .*
>
> You could try if it works for your use cases..
>
> Thanks,
> Gao Xiang
>
> >
> > [1]: https://github.com/erofs/erofs-utils/commit/dac31f7eb228601c457c63=
38e6df8dabfcbb039b
> >
> > Best regards,
> > Keiichi
