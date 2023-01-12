Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 69731666B4F
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 07:56:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NswLl2RlDz3cD5
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Jan 2023 17:56:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NswLh0j7dz3c4w
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Jan 2023 17:56:11 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VZQ6pQ5_1673506559;
Received: from 30.221.131.229(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZQ6pQ5_1673506559)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 14:56:08 +0800
Message-ID: <d2c6aca7-b2ed-1df6-c97a-246256fd0e18@linux.alibaba.com>
Date: Thu, 12 Jan 2023 14:55:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] erofs: add documentation for 'domain_id' mount
 option
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20230112065431.124926-1-jefflexu@linux.alibaba.com>
 <20230112065431.124926-2-jefflexu@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20230112065431.124926-2-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-doc@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

cc: linux-doc@vger.kernel.org

On 1/12/23 2:54 PM, Jingbo Xu wrote:
> Since the EROFS share domain feature for fscache mode has been available
> since Linux v6.1, let's add documentation for 'domain_id' mount option.
> 
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  Documentation/filesystems/erofs.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 067fd1670b1f..a43aacf1494e 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -120,6 +120,8 @@ dax={always,never}     Use direct access (no page cache).  See
>  dax                    A legacy option which is an alias for ``dax=always``.
>  device=%s              Specify a path to an extra device to be used together.
>  fsid=%s                Specify a filesystem image ID for Fscache back-end.
> +domain_id=%s           Specify a domain ID in fscache mode so that different images
> +                       with the same blobs under a given domain ID can share storage.
>  ===================    =========================================================
>  
>  Sysfs Entries

-- 
Thanks,
Jingbo
