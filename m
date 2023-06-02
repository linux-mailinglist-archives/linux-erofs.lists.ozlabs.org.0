Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A290D71FE1E
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 11:43:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXdN22GTsz3dy2
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 19:42:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXdMy1V1rz3cCn
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 19:42:52 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vk9UqKI_1685698964;
Received: from 30.97.48.207(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk9UqKI_1685698964)
          by smtp.aliyun-inc.com;
          Fri, 02 Jun 2023 17:42:45 +0800
Message-ID: <0d375b77-36fa-d635-718e-9ec24d39d1b7@linux.alibaba.com>
Date: Fri, 2 Jun 2023 17:42:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] erofs-utils: fsck: check packed inode only by valid
 packed_nid
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <b07be6197e879b8200b4c25f91957d6a206dc143.1685697802.git.huyue2@coolpad.com>
 <ba534c32f9a96d6492917b5bf333d31edc936d31.1685697802.git.huyue2@coolpad.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ba534c32f9a96d6492917b5bf333d31edc936d31.1685697802.git.huyue2@coolpad.com>
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
Cc: sunshijie@xiaomi.com, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/2 17:37, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Since dedupe feature is also using the same feature bit as fragments.
> 
> Fixes: 017f5b402d14 ("erofs-utils: fsck: add a check to packed inode")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

We should check both
erofs_sb_has_fragments() && sbi.packed_nid > 0 here.

Thanks,
Gao Xiang
