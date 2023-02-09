Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D14C68FF96
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 06:01:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC4TP6X0Pz3ch9
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 16:01:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC4TF43fjz3c6R
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 16:01:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbETTZ7_1675918872;
Received: from 30.221.133.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbETTZ7_1675918872)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 13:01:12 +0800
Message-ID: <9ac23fbe-7bfe-68f6-a9b5-6c722d0fe629@linux.alibaba.com>
Date: Thu, 9 Feb 2023 13:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] erofs: simplify the name collision checking in share
 domain mode
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 zhujia.zj@bytedance.com, houtao1@huawei.com
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
In-Reply-To: <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/8/23 3:17 PM, Jingbo Xu wrote:
> When share domain is enabled, data blobs can be shared among filesystem
> instances in the same domain for data deduplication, while bootstrap
> blobs are always dedicated to the corresponding filesystem instance, and
> have no need to be shared.
> 
> In the initial implementation of share domain (commit 7d41963759fe
> ("erofs: Support sharing cookies in the same domain")), bootstrap blobs
> are also in the share domain, and thus can be referenced by the
> following filesystem instances.  In this case, mounting twice with the
> same fsid and domain_id will trigger warning in sysfs.  Commit
> 27f2a2dcc626 ("erofs: check the uniqueness of fsid in shared domain in
> advance") fixes this by introducing the name collision checking.
> 
> This patch attempts to fix the above issue in another simpler way.
> Since the bootstrap blobs have no need to be shared, move them out of
> the share domain, so that one bootstrap blob can not be referenced by
> other filesystem instances.  Attempt to mount twice with the same fsid
> and domain_id will fail with info of duplicate cookies, which is
> consistent with the behavior in non-share-domain mode.
> 

In non-share-domain mode, the uniqueness of primary data blob is
actually guaranteed by fscache_acquire_volume(), since
fscache_acquire_volume() will fail if attempt to mount the same fsid twice.

Thus hold on for this patch.


-- 
Thanks,
Jingbo
