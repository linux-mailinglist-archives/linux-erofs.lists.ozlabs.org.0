Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDB783CDC
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 11:26:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVP9s1BRrz30Ng
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 19:26:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVP9p2fzsz2y1b
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Aug 2023 19:26:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqM644i_1692696392;
Received: from 30.221.148.214(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqM644i_1692696392)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 17:26:33 +0800
Message-ID: <e392d7b1-8aca-ee0b-93a5-66a49fe17b75@linux.alibaba.com>
Date: Tue, 22 Aug 2023 17:26:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/11] erofs-utils: lib: fix erofs_init_devices
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org, linux-erofs@lists.ozlabs.org
References: <20230822092457.114686-1-jefflexu@linux.alibaba.com>
 <20230822092457.114686-2-jefflexu@linux.alibaba.com>
In-Reply-To: <20230822092457.114686-2-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 8/22/23 5:24 PM, Jingbo Xu wrote:
> |[1]
> https://github.com/erofs/erofsnightly/actions/runs/5921003885/job/16053013007|

Oops.  This is included by mistake...

-- 
Thanks,
Jingbo
