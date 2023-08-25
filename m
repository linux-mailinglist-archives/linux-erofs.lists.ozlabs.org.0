Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72E787D0D
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Aug 2023 03:18:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O8F3+JLy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RX2Cd4Zhcz3c9c
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Aug 2023 11:18:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O8F3+JLy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RX2CX3qJSz3c3R
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Aug 2023 11:18:48 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AB3436135A;
	Fri, 25 Aug 2023 01:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9110FC433C8;
	Fri, 25 Aug 2023 01:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692926324;
	bh=DapHkQT8X84yWNvGu8oqRCoyMLM4nfpncPTa+wsDc9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O8F3+JLyUJBelWixtfLPasTBEJs5UvdebGcBmQ58wEViQF0gncFfL3DBtYFsQVNxF
	 WR/z99kIEVDjOSN6c7XC5hfg/hE2tAr9Pudud0O5yPUZ6ZuKZoeDS14J1MEAkKVgdv
	 lgzAEuAcBkJGpmnluJaAtxY6A44LsH71MJVsl7ZUNzVtt5Ax9VwaUXQljF72oNeC34
	 GbBm7A4Sc70cxf0wPX62cLK9IiJPMhc5Acjj6jLTGTlCTkyQCCQbPYF1R/TQ8Cv6CH
	 xBlNEQwN9z421lKSDy+6LEEoAXMA37jjy1rNMOgXxTN3lNR1lmeNiG3StQN1YBOfbM
	 G207gAVdnZxOw==
Message-ID: <96ffa54c-84e1-c953-23cd-ce68dd9350df@kernel.org>
Date: Fri, 25 Aug 2023 09:18:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 06/45] erofs: dynamically allocate the erofs-shrinker
Content-Language: en-US
To: Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
 david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz, roman.gushchin@linux.dev,
 djwong@kernel.org, brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-7-zhengqi.arch@bytedance.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230824034304.37411-7-zhengqi.arch@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Yue Hu <huyue2@coolpad.com>, Muchun Song <songmuchun@bytedance.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/8/24 11:42, Qi Zheng wrote:
> Use new APIs to dynamically allocate the erofs-shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Gao Xiang <xiang@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: Yue Hu <huyue2@coolpad.com>
> CC: Jeffle Xu <jefflexu@linux.alibaba.com>
> CC: linux-erofs@lists.ozlabs.org

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
