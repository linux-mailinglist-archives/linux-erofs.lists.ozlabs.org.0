Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119D974E620
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 06:56:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689051365;
	bh=neFmxDP1G35VH96pTfl/+/QwCBkiBYN1gaMl3ckTMbY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ezfweqnumLsQMphTTgRfvTD7hLXw2nMns49SuZfNSvVBVmf7lVlYREefurXZiAktk
	 lKJS/K53VVqmcHdzD8Bv9+FZU6DXhvOYpNeHkPJNjtLLZGygMCOTur02goC607takD
	 1cNx1w0+TzfQaBaC+Rlxj8P/bI4WFB+5QkDKZwnk0h+e52gIXNQa5f7XgKolBN/OZD
	 ySn0BAlr4zITxOPNimxXGHol+fD4h2om2AAJg7epulz35B/G94BvjYblew2DBYjT07
	 qZXk+/VzS4lCdxc4Iwh9BlGVO13V5YoU53Bm3KKBlhXc3tXWWOEDWAbCHpLD7FbEul
	 fHw47LlkACFCQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0T916hYlz3cXs
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 14:56:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Cvl6Xa8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com; envelope-from=yinxin.x@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0T8W3CYMz3cJ7
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 14:55:37 +1000 (AEST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so79492031fa.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 21:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689051330; x=1691643330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neFmxDP1G35VH96pTfl/+/QwCBkiBYN1gaMl3ckTMbY=;
        b=k+yXYs7ECSdS/51tkZuSp656sVsZtwx1S3H668xOtm4DCpmwyHSq+fXOUBd2+R/ZIx
         20EhMOswYnGZ2r5w9fpeemQLBHvReVk4OWFU6MnFxUB/p+m3ULLcqRUUdVIZ7NOVWm9Z
         QVRU/F4AvJ1IYoYsHXSq+0oGGSAArexNVyR98+UH10hS96hP59+Sxck2pOc+Zr2qecY+
         BL4QRNgi2LP/fOufnXP24B4QxpfwxVWUf6npWIB4hjA/RtSEFVw1qB7Jc7gy9ulk0t4V
         xhmQBpniX+mfuwtjbXLJWncgvkVr+1mLpAf2ZIN9oFTTE4W1X5euTK6iXOMmti/MaPTh
         1LYg==
X-Gm-Message-State: ABy/qLbia2qqEu1A+KIzk1XpddR7zrnnq4umU05F5BZDGrC/JyBU4cHH
	gVA3XRWwnYIaHBNnrFBZsg67E8Ycba4KsyS9wbX+Uw==
X-Google-Smtp-Source: APBJJlFerdqgceSJuF3zqyIoVziFZKLdeFOZDL8ZO5zUz8eAVPf+MEDhhmf7dmn5hxuZl8zxDRDFhEz9ju0qcvtDPfI=
X-Received: by 2002:a19:6756:0:b0:4fb:897d:d097 with SMTP id
 e22-20020a196756000000b004fb897dd097mr11523527lfj.44.1689051330451; Mon, 10
 Jul 2023 21:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230711040239.7410-1-yinxin.x@bytedance.com> <c0dab57b-0687-5b44-cdbf-151475f77576@linux.alibaba.com>
In-Reply-To: <c0dab57b-0687-5b44-cdbf-151475f77576@linux.alibaba.com>
Date: Tue, 11 Jul 2023 12:55:19 +0800
Message-ID: <CAK896s4jupDX39ns-kfMtyRf-UDt5CAAcKkU1fOLv-wAH7w_qg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] erofs: enable dax for chunk based regular file
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
From: Xin Yin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Xin Yin <yinxin.x@bytedance.com>
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 11, 2023 at 12:08=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> Hi Xin,
>
> On 2023/7/11 12:02, Xin Yin wrote:
> > DAX can be used to share page cache between VMs, reducing guest memory
> > overhead. And chunk based data format is widely used for VM and
> > container image. So enable dax support for it, make erofs better used
> > for VM scenarios.
> >
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
>
> I really think it's a regression honestly, how about updating
> the subject line to:
>
> "erofs: fix fsdax unavailability for chunk-based regular files"
>
> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed fil=
es")
>
OK , I will update and resend the new patch.

Thanks,
Xin Yin
> Thanks,
> Gao Xiang
