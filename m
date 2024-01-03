Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5AF822C05
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 12:21:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T4nNy2tfXz3cRk
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 22:21:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T4nNs3vk2z30g2
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jan 2024 22:21:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vzu.U90_1704280900;
Received: from 30.222.32.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vzu.U90_1704280900)
          by smtp.aliyun-inc.com;
          Wed, 03 Jan 2024 19:21:41 +0800
Message-ID: <d049d7ac-4ae6-4fd0-96a4-7b0729fd3367@linux.alibaba.com>
Date: Wed, 3 Jan 2024 19:21:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFJlcXVlc3QgZm9y?=
 =?UTF-8?Q?_Assistance=3A_Decompressing_EROFS_Image_without_Mounting?=
To: =?UTF-8?B?546L56GV?= <wangshuo16@xiaomi.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <e751bfc68f524227ad8ad98faa8102af@xiaomi.com>
 <1616817c-7759-41f1-8c6b-568fb7357212@linux.alibaba.com>
 <5ee2a6ba360d40239d18845d0f21e31e@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5ee2a6ba360d40239d18845d0f21e31e@xiaomi.com>
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



On 2024/1/3 19:09, 王硕 via Linux-erofs wrote:
> Hi,
> 
> 
> Thanks for your reply, and I have tried the option you suggested but failed.Could you help me to solve it?
> 
> Following is the result of executing the option:
> 
> 
> 
> 
> (I have downloaded the source code from https://github.com/erofs/erofs-utils/tree/dev <https://github.com/erofs/erofs-utils/tree/dev>, and make install on my Ubuntu20.04)

  - Could you use a newer distribution instead such as Debian 12?
Otherwise it will be more complicated, because lz4/lzma weren't
build-in according to the snapshot.

  - It should be "fsck.erofs --extract=mi_ext mi_ext.img"

  - As for Xiaomi Corp, is there some other colleague which can
help you resolve this?

Thanks,
Gao Xiang
