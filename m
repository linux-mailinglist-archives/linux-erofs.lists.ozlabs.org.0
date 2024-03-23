Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE28879C5
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 18:33:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V25rB0H0pz3cM5
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Mar 2024 04:32:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.237; helo=smtp237.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp237.sjtu.edu.cn (smtp237.sjtu.edu.cn [202.120.2.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V25r74Df2z3c20
	for <linux-erofs@lists.ozlabs.org>; Sun, 24 Mar 2024 04:32:55 +1100 (AEDT)
Received: from proxy189.sjtu.edu.cn (smtp189.sjtu.edu.cn [202.120.2.189])
	by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id 480167FB50;
	Sun, 24 Mar 2024 01:32:53 +0800 (CST)
Received: from [127.0.0.1] (unknown [111.186.0.119])
	by proxy189.sjtu.edu.cn (Postfix) with ESMTPSA id BAD193FC576;
	Sun, 24 Mar 2024 01:32:50 +0800 (CST)
Message-ID: <d484e3e9-3fd0-4f00-b4a1-26c5cc20a8c9@sjtu.edu.cn>
Date: Sun, 24 Mar 2024 01:32:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] erofs-utils: mkfs: introduce inter-file
 multi-threaded compression
To: Huang Jianan <jnhuang95@gmail.com>
References: <20240322102421.3780992-1-zhaoyifan@sjtu.edu.cn>
 <CAJfKizp5EW3Jg27pizH85oNhGUD4X=VjppxhH94tn_q9S_h1Tw@mail.gmail.com>
Content-Language: en-CA
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <CAJfKizp5EW3Jg27pizH85oNhGUD4X=VjppxhH94tn_q9S_h1Tw@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/3/23 10:51, Huang Jianan wrote:
> Hi, Yifan,
>
> I got some warnings and errors via checkpatch.pl on this patchset. You can
> check and fix them since erofs-utils follows kernel coding style.

Roger that. Will do it in next patches.


Thanks,

Yifan Zhao

>
> Thanks,
> Jianan
>
> Yifan Zhao <zhaoyifan@sjtu.edu.cn> 于2024年3月22日周五 18:24写道：
>> change log since v2:
>> - erofs_queue => erofs_inode_fifo, defined in inode.c
>>
>> Yifan Zhao (2):
>>    erofs-utils: lib: split function logic in inode.c
>>    erofs-utils: mkfs: introduce inter-file multi-threaded compression
>>
>>   include/erofs/compress.h |  16 ++
>>   include/erofs/inode.h    |  17 ++
>>   include/erofs/internal.h |   3 +
>>   lib/compress.c           | 336 +++++++++++++++++++++------------
>>   lib/inode.c              | 399 +++++++++++++++++++++++++++++++++------
>>   5 files changed, 593 insertions(+), 178 deletions(-)
>>
>> --
>> 2.44.0
>>
