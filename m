Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFB4B82C8
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Feb 2022 09:18:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jz9nN6DSkz3bZ2
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Feb 2022 19:18:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jz9nH1g9Rz2xsb
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Feb 2022 19:17:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R621e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V4cQ8KA_1644999462; 
Received: from 30.225.24.51(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V4cQ8KA_1644999462) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Feb 2022 16:17:44 +0800
Message-ID: <b33d4e29-bf89-13cf-17f3-63208bf8f70d@linux.alibaba.com>
Date: Wed, 16 Feb 2022 16:17:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v3 05/22] cachefiles: introduce new devnode for on-demand
 read mode
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-6-jefflexu@linux.alibaba.com>
 <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
 <YguCYmvdyRAOjHcP@kroah.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YguCYmvdyRAOjHcP@kroah.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/15/22 6:37 PM, Greg KH wrote:
> On Tue, Feb 15, 2022 at 05:03:16PM +0800, JeffleXu wrote:
>> Hi David,
>>
>> FYI I've updated this patch on [1].
>>
>> [1]
>> https://github.com/lostjeffle/linux/commit/589dd838dc539aee291d1032406653a8f6269e6f.
> 
> We can not review random github links :(

Thanks. The new version patch has been replied in the email.

-- 
Thanks,
Jeffle
