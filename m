Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88237881ACF
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 03:00:19 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OuNKXK+/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0TDs0Hbgz3d4H
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 13:00:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OuNKXK+/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0TDf5xD4z3cRd
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 13:00:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710986396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uWMAWMZypugp1QQRUZrlMACjjQriuT08o47bqRCzOLY=;
	b=OuNKXK+/+86y3QFWEK5JpYmM+f8I5RetW3mFe7kjlbWErUvIXnYyHCNoHynsQ+p5NQbfAhFVDbR1lZERqSwi6TDDG1g5UXK2ogd6YjiUvIkAT2xLFIfgKWOoBwaKrpXQDTD3TZRV0TXFLvrc4f8JUpWkQpK/yHqIW8Kg3NC6h5w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W2yz9Xi_1710986394;
Received: from 30.97.48.205(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2yz9Xi_1710986394)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 09:59:55 +0800
Message-ID: <a80f7239-2c16-479c-8722-7f6b0300eeed@linux.alibaba.com>
Date: Thu, 21 Mar 2024 09:59:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] erofs-utils: add a helper to get available
 processors
To: Huang Jianan <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20240315011019.610442-1-hsiangkao@linux.alibaba.com>
 <20240315011019.610442-2-hsiangkao@linux.alibaba.com>
 <1c82cf0e-be69-4480-ba13-744d4ddf9251@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1c82cf0e-be69-4480-ba13-744d4ddf9251@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/21 02:15, Huang Jianan wrote:
> On 2024/3/15 9:10, Gao Xiang wrote:
> 
>> In order to prepare for multi-threaded decompression.
> 
> multi-threaded compression.

It already merged into -dev.  I would not update this
since it's a minor stuff.  Let's work on inter-file
stuffs.

Thanks,
Gao Xiang
