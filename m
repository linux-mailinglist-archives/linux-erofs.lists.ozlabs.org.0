Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C49930F04
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2024 09:43:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H9SRlJVH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WMvMn5D9Nz3cZs
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2024 17:43:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H9SRlJVH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WMvMh2bZsz30T3
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jul 2024 17:43:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721029418; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PdxgbJId77jvdW5ocN/HY2J0p88IQRCfmIow3VWOMfk=;
	b=H9SRlJVHW8AuP+L/lVBssxsus3hbiJ7wa7grQeYtcBlbfqv+ukOcPqJs6JPQZM9igEvg3nSNdROgib+e7SjTWKbouQXgB40jrNvvvVCZKQzfVUkhZngjSDcIblzXSifp9mL3xBUx0n+etWhPZICMnBWj2wFPDJap19DSofgG5M0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WAXxOeK_1721029415;
Received: from 30.97.48.209(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAXxOeK_1721029415)
          by smtp.aliyun-inc.com;
          Mon, 15 Jul 2024 15:43:36 +0800
Message-ID: <f630cbad-d653-44e7-8d31-3cbb90899401@linux.alibaba.com>
Date: Mon, 15 Jul 2024 15:43:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue of erofs use zstd
To: =?UTF-8?B?6IKW5re85qOu?= <xiaomiaosen@xiaomi.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <0a71474744854fcf967e99666e8eab38@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0a71474744854fcf967e99666e8eab38@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/15 15:33, 肖淼森 via Linux-erofs wrote:
> Hi GaoXiang,
> 
> 
> We just update the last erofs version, and want to test the zstd compress feature.
> 
> But it will throw some error when using the mkfs.erofs making the new image, could you help to check? thanks!

Please fix your own environment issue yourself, thanks.

This mailing list is not used for discussing such out-of-topic issue.

Thanks,
Gao Xiang
