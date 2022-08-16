Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 124FA595245
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Aug 2022 07:59:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M6L7R473Dz3bXg
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Aug 2022 15:58:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M6L7M4htxz2y2B
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Aug 2022 15:58:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VMOoIJo_1660629528;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VMOoIJo_1660629528)
          by smtp.aliyun-inc.com;
          Tue, 16 Aug 2022 13:58:50 +0800
Date: Tue, 16 Aug 2022 13:58:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] erofs-utils: fuse: introduce xattr support
Message-ID: <YvsyGOZsoFXFSQXw@B-P7TQMD6M-0146.local>
References: <20220728120910.61636-1-jnhuang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220728120910.61636-1-jnhuang@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, Sheng Yong <shengyong@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

( +Cc Sheng Yong )

On Thu, Jul 28, 2022 at 08:09:09PM +0800, Huang Jianan wrote:
> This implements xattr functionalities for erofsfuse. A large amount
> of code was adapted from Linux kernel.
> 
> Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>

I've applied this patch.  Yet if you have extra time, could you
update fsck.erofs supporting xattr extraction as well?

Thanks,
Gao Xiang
