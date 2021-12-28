Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C2480924
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 13:34:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNYrw40mdz2yw9
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 23:34:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNYrp26FJz2ymq
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 23:34:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V06peAr_1640694869; 
Received: from 30.225.24.30(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V06peAr_1640694869) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Dec 2021 20:34:30 +0800
Message-ID: <de5dfac5-9c33-a4e2-e5f1-39547a409fd0@linux.alibaba.com>
Date: Tue, 28 Dec 2021 20:34:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 01/23] cachefiles: add cachefiles_demand devnode
Content-Language: en-US
To: Joseph Qi <joseph.qi@linux.alibaba.com>, dhowells@redhat.com,
 linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-2-jefflexu@linux.alibaba.com>
 <d066131d-1bcb-e64d-a10b-b3dbb4506b96@linux.alibaba.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <d066131d-1bcb-e64d-a10b-b3dbb4506b96@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 eguan@linux.alibaba.com, gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 12/28/21 10:47 AM, Joseph Qi wrote:

> 
> Better to prepare the on-demand read() and poll() first, and then add
> the on-demand cachefiles dev.
> 

Regards. Thanks.

-- 
Thanks,
Jeffle
