Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D3281D42F
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Dec 2023 14:32:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sy4pk0mD6z3c4h
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Dec 2023 00:32:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sy4pY2xzvz2yks
	for <linux-erofs@lists.ozlabs.org>; Sun, 24 Dec 2023 00:32:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0Vz1O0tF_1703338328;
Received: from 30.25.242.252(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vz1O0tF_1703338328)
          by smtp.aliyun-inc.com;
          Sat, 23 Dec 2023 21:32:11 +0800
Message-ID: <fac01751-73dc-4d93-b9c0-b637fece8334@linux.alibaba.com>
Date: Sat, 23 Dec 2023 21:32:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix EROFS Kconfig
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 David Howells <dhowells@redhat.com>, Gao Xiang <xiang@kernel.org>
References: <20231221132400.1601991-5-dhowells@redhat.com>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <2265065.1703250126@warthog.procyon.org.uk>
 <d50555e9-3b8e-41d4-bec6-317aaaec5ff0@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d50555e9-3b8e-41d4-bec6-317aaaec5ff0@linux.alibaba.com>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Yue Hu <huyue2@coolpad.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David and Jingbo,

On 2023/12/23 11:55, Jingbo Xu wrote:
> Hi,
> 
> On 12/22/23 9:02 PM, David Howells wrote:
>> This needs an additional change (see attached).
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index 1d318f85232d..1949763e66aa 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -114,7 +114,8 @@ config EROFS_FS_ZIP_DEFLATE
>>   
>>   config EROFS_FS_ONDEMAND
>>   	bool "EROFS fscache-based on-demand read support"
>> -	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
>> +	depends on CACHEFILES_ONDEMAND && FSCACHE && \
>> +		(EROFS_FS=m && NETFS_SUPPORT || EROFS_FS=y && NETFS_SUPPORT=y)
>>   	default n
>>   	help
>>   	  This permits EROFS to use fscache-backed data blobs with on-demand
>>
> 
> Thanks for the special reminder.  I noticed that it has been included in
> this commit[*] in the dev tree.
> 
> [*]
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=netfs-lib&id=7472173cc3baf4a0bd8c803e56c37efdb8388f1c
> 
> 
> Besides I noticed an issue when trying to configure EROFS_FS_ONDEMAND.
> The above kconfig indicates that EROFS_FS_ONDEMAND depends on
> NETFS_SUPPORT, while NETFS_SUPPORT has no prompt in menuconfig and can
> only be selected by, e.g. fs/ceph/Kconfig:
> 
> 	config CEPH_FS
>          select NETFS_SUPPORT
> 
> IOW EROFS_FS_ONDEMAND will not be prompted and has no way being
> configured if NETFS_SUPPORT itself is not selected by any other filesystem.
> 
> 
> I tried to fix this in following way:
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 1949763e66aa..5b7b71e537f1 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -5,6 +5,7 @@ config EROFS_FS
>          depends on BLOCK
>          select FS_IOMAP
>          select LIBCRC32C
> +       select NETFS_SUPPORT if EROFS_FS_ONDEMAND
>          help
>            EROFS (Enhanced Read-Only File System) is a lightweight read-only
>            file system with modern designs (e.g. no buffer heads, inline
> @@ -114,8 +115,10 @@ config EROFS_FS_ZIP_DEFLATE
> 
>   config EROFS_FS_ONDEMAND
>          bool "EROFS fscache-based on-demand read support"
> -       depends on CACHEFILES_ONDEMAND && FSCACHE && \
> -               (EROFS_FS=m && NETFS_SUPPORT || EROFS_FS=y &&
> NETFS_SUPPORT=y)
> +       depends on EROFS_FS
> +       select FSCACHE
>          default n
>          help
>            This permits EROFS to use fscache-backed data blobs with on-demand
> 
> 
> But still the dependency for CACHEFILES_ONDEMAND and CACHEFILES can not
> be resolved.  Though CACHEFILES is not a must during the linking stage
> as EROFS only calls fscache APIs directly, CACHEFILES is indeed needed
> to ensure that the EROFS on-demand functionality works at runtime.
> 
> If we let EROFS_FS_ONDEMAND select CACHEFILES_ONDEMAND, then only
> CACHEFILES_ONDEMAND will be selected while CACHEFILES can be still N.
> Maybe EROFS_FS_ONDEMAND needs to selct both CACHEFILES_ONDEMAND and
> CACHEFILES?

I think the main point here is that we don't have an explicit
menuconfig item for either netfs or fscache directly.

In principle, EROFS ondemand feature only needs fscache "volume
and cookie" management framework as well as cachefiles since
they're all needed to manage EROFS cached blobs, but I'm fine
if that needs NETFS_SUPPORT is also enabled.

If netfs doesn't have a plan for a new explicit menuconfig
item for users to use, I think we have to enable as below:

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1d318f85232d..fffd3919343e 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -114,8 +114,11 @@ config EROFS_FS_ZIP_DEFLATE

  config EROFS_FS_ONDEMAND
  	bool "EROFS fscache-based on-demand read support"
-	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
-	default n
+	depends on EROFS_FS
+	select NETFS_SUPPORT
+	select FSCACHE
+	select CACHEFILES
+	select CACHEFILES_ONDEMAND
  	help
  	  This permits EROFS to use fscache-backed data blobs with on-demand
  	  read support.
--
2.39.3

But cachefiles won't be complied as modules anymore. Does it
sounds good?

Thanks,
Gao Xiang
