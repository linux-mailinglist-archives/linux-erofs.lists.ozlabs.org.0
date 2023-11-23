Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8D7F5DBA
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 12:23:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SbbMY1fD5z3dL2
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 22:23:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.3; helo=out199-3.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SbbMS35H8z3dBD
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 22:23:13 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VwzG0Dx_1700738570;
Received: from 30.25.230.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VwzG0Dx_1700738570)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 19:22:52 +0800
Message-ID: <cad09af0-3911-7ef7-fa26-def5c6310008@linux.alibaba.com>
Date: Thu, 23 Nov 2023 19:22:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] erofs-utils: mkfs: generate on-disk indexes after
 compression
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20231106125824.153563-1-zhaoyifan@sjtu.edu.cn>
 <20231107092343.200359-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231107092343.200359-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yifan,

On 2023/11/7 17:23, Yifan Zhao wrote:
> Currently, mkfs generates the on-disk indexes of each compressed extent
> on the fly during compressing, which is inflexible if we'd like to merge
> sub-indexes of a file later for the multi-threaded compression scenarios.
> 
> Let's generate on-disk indexes after the compression for the file is
> completed.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---

Sorry for the late reply.  There are some issues on my side.
In order to make this work efficient.  Let me to refine this commit as well.

Thanks,
Gao Xiang

