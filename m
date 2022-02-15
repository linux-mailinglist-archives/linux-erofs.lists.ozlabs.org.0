Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCD54B66E3
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Feb 2022 10:03:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JyZrZ1XMZz3c79
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Feb 2022 20:03:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JyZrP2V2kz3bT0
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Feb 2022 20:03:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V4Xi.eo_1644915796; 
Received: from 30.225.24.85(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V4Xi.eo_1644915796) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 15 Feb 2022 17:03:17 +0800
Message-ID: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
Date: Tue, 15 Feb 2022 17:03:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v3 05/22] cachefiles: introduce new devnode for on-demand
 read mode
Content-Language: en-US
From: JeffleXu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-6-jefflexu@linux.alibaba.com>
In-Reply-To: <20220209060108.43051-6-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

FYI I've updated this patch on [1].

[1]
https://github.com/lostjeffle/linux/commit/589dd838dc539aee291d1032406653a8f6269e6f.

This new version mainly adds cachefiles_ondemand_flush_reqs(), which
drains the pending read requests when cachefilesd is going to exit.

On 2/9/22 2:00 PM, Jeffle Xu wrote:
> This patch introduces a new devnode 'cachefiles_ondemand' to support the
> newly introduced on-demand read mode.
> 
> The precondition for on-demand reading semantics is that, all blob files
> have been placed under corresponding directory with correct file size
> (sparse files) on the first beginning. When upper fs starts to access
> the blob file, it will "cache miss" (hit the hole) and then turn to user
> daemon for preparing the data.
> 
> The interaction between kernel and user daemon is described as below.
> 1. Once cache miss, .ondemand_read() callback of corresponding fscache
>    backend is called to prepare the data. As for cachefiles, it just
>    packages related metadata (file range to read, etc.) into a pending
>    read request, and then the process triggering cache miss will fall
>    asleep until the corresponding data gets fetched later.
> 2. User daemon needs to poll on the devnode ('cachefiles_ondemand'),
>    waiting for pending read request.
> 3. Once there's pending read request, user daemon will be notified and
>    shall read the devnode ('cachefiles_ondemand') to fetch one pending
>    read request to process.
> 4. For the fetched read request, user daemon need to somehow prepare the
>    data (e.g. download from remote through network) and then write the
>    fetched data into the backing file to fill the hole.
> 5. After that, user daemon need to notify cachefiles backend by writing a
>    'done' command to devnode ('cachefiles_ondemand'). It will also
>    awake the previous asleep process triggering cache miss.
> 6. By the time the process gets awaken, the data has been ready in the
>    backing file. Then process can re-initiate a read request from the
>    backing file.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---


-- 
Thanks,
Jeffle
