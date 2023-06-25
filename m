Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C5F73CFF3
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Jun 2023 11:58:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qpmd50dshz30Pc
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Jun 2023 19:58:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qpmd21gP7z2ydP
	for <linux-erofs@lists.ozlabs.org>; Sun, 25 Jun 2023 19:58:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vls3cRt_1687687084;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vls3cRt_1687687084)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 17:58:05 +0800
Message-ID: <c70c50c5-b058-defd-8046-73d1020ce48a@linux.alibaba.com>
Date: Sun, 25 Jun 2023 17:58:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs-utils: lib: fallback for copy_file_range
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20230625080819.44502-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230625080819.44502-1-zhaoyifan@sjtu.edu.cn>
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



On 2023/6/25 16:08, Yifan Zhao wrote:
> If tmpfs is used for /tmp and blob device is not specified, we need to
> copy data between two different file systems during mkfs, which is not
> supported by the copy_file_range() syscall. In this case, let's give it
> a second chance by fallback to __erofs_copy_file_range().
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

Thanks for catching this!
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
