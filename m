Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704B7BC4E6
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Oct 2023 07:50:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S2ZCC0YJgz3cR9
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Oct 2023 16:50:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S2ZC64PCDz3c8r
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Oct 2023 16:50:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VtWs9YV_1696657815;
Received: from 30.97.48.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VtWs9YV_1696657815)
          by smtp.aliyun-inc.com;
          Sat, 07 Oct 2023 13:50:17 +0800
Message-ID: <d762d811-0940-680c-d103-6c92fa472205@linux.alibaba.com>
Date: Sat, 7 Oct 2023 13:50:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 08/29] erofs: move erofs_xattr_handlers and
 xattr_handler_map to .rodata
To: Wedson Almeida Filho <wedsonaf@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-9-wedsonaf@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230930050033.41174-9-wedsonaf@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, Wedson Almeida Filho <walmeida@microsoft.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/9/30 13:00, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> erofs_xattr_handlers or xattr_handler_map at runtime.
> 
> Cc: Gao Xiang <xiang@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: Yue Hu <huyue2@coolpad.com>
> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> Cc: linux-erofs@lists.ozlabs.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
