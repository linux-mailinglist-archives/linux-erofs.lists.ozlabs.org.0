Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24B4A2C17
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 07:13:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm3tB4YWdz3Wtt
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 17:13:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm3t32mp8z30Dg
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 17:13:27 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V35W5TZ_1643436798; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V35W5TZ_1643436798) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 29 Jan 2022 14:13:19 +0800
Date: Sat, 29 Jan 2022 14:13:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Eisberg <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
Message-ID: <YfTa/rxeiwycbAKp@B-P7TQMD6M-0146>
References: <20220128132218.26-1-igoreisberg@gmail.com>
 <CABjEcnGhBLMd1wKC_hjQa8FuO6mFvmC3rxFCgi3fBr0omnymSQ@mail.gmail.com>
 <YfTXDoeqz0dNafhf@B-P7TQMD6M-0146>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfTXDoeqz0dNafhf@B-P7TQMD6M-0146>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jan 29, 2022 at 01:56:30PM +0800, Gao Xiang wrote:
> On Sat, Jan 29, 2022 at 07:47:31AM +0200, Igor Eisberg wrote:
> > Point regarding conclusive messages taken, will revert the relevant lines.
> 
> Thank.
> 
> > As for the time variable, all I did was to match it to the format as in the
> > case of HAVE_UTIMENSAT, just above it.
> > Although the variable isn't used further, inlining it is unreadable.
> > 
> 
> Please don't. Otherwise, complier will complain
> "mixed declarations and code"
> 
> and I don't want to initialize such structures at the beginning of any
> block.

Add some word. Actually, I'd like to add:
if (!fsckcfg.extract_path)
	return;

at the beginning of erofsfsck_set_attributes() instead of
using "if (!ret && fsckcfg.extract_path)" in the caller.

So the HAVE_UTIMENSAT case needs to be resolved as well.

Btw, I have no idea why it could become unreadable to you, first,
it would avoid "mixed declarations and code" unless defining them at the
beginning of blocks, and I don't like memset(.., 0, ) and set
independently since memset generally is a library function (unless
compliers do some built-in tricks) rather than a language feature.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
