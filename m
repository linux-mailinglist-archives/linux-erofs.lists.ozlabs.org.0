Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114604B0FC0
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Feb 2022 15:08:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jvdrl4hj7z3bYh
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Feb 2022 01:08:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jvdrc6rndz3bVB
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Feb 2022 01:08:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V44bNBK_1644502092; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V44bNBK_1644502092) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Feb 2022 22:08:13 +0800
Date: Thu, 10 Feb 2022 22:08:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/5] fs/erofs: new filesystem
Message-ID: <YgUcSxPUJPXz3hES@B-P7TQMD6M-0146.local>
References: <20210823123646.9765-1-jnhuang95@gmail.com>
 <20220208140513.30570-1-jnhuang95@gmail.com>
 <YgUIaIWOpfOJfukN@B-P7TQMD6M-0146.local>
 <20220210133455.GE2697206@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210133455.GE2697206@bill-the-cat>
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 10, 2022 at 08:34:55AM -0500, Tom Rini wrote:
> On Thu, Feb 10, 2022 at 08:43:20PM +0800, Gao Xiang wrote:
> 
> > Hi Tom,
> > 
> > Would you mind taking some time having a look at this version
> > if it meets what's needed, so we could have a chance to be
> > merged in the next u-boot version?
> > 
> > It's almost in sync with the latest erofs-utils soruce code,
> > so it can be upgraded easily in the future together with the
> > later erofs-utils versions.
> 
> Things seem fine, we just need to also update the Dockerfile with tools
> so that the tests are run.

Many thanks! Hopefully Jianan could fill the gap later.

Thanks,
Gao Xiang

> 
> -- 
> Tom


