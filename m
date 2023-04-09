Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3E6DBFD2
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:26:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvWYP2WN0z3cf0
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:26:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PvWYJ6ybXz3cd5
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:26:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vfd3ng-_1681043163;
Received: from 30.213.177.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vfd3ng-_1681043163)
          by smtp.aliyun-inc.com;
          Sun, 09 Apr 2023 20:26:06 +0800
Message-ID: <c3404990-f164-ba30-593f-44aa1fa12e3d@linux.alibaba.com>
Date: Sun, 9 Apr 2023 20:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 1/5] erofs-utils: lib: rb_tree: fix broken rb_iter_init()
 prototype
To: =?UTF-8?Q?Ahelenia_Ziemia=c5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/9 19:56, Ahelenia Ziemiańska wrote:
> In file included from rb_tree.c:34:
> ./rb_tree.h:96:17: warning: a function declaration without a prototype
> is deprecated in all versions of C and is treated as a zero-parameter
> prototype in C2x, conflicting with a subsequent definition
> [-Wdeprecated-non-prototype]
> struct rb_iter *rb_iter_init            ();
>                  ^
> rb_tree.c:422:1: note: conflicting prototype is here
> rb_iter_init (struct rb_iter *self) {
> ^
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   lib/rb_tree.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/rb_tree.h b/lib/rb_tree.h
> index 5b35c74..67ec0a7 100644
> --- a/lib/rb_tree.h
> +++ b/lib/rb_tree.h
> @@ -93,7 +93,7 @@ int             rb_tree_remove_with_cb  (struct rb_tree *self, void *value, rb_t
>   int             rb_tree_test            (struct rb_tree *self, struct rb_node *root);
>   
>   struct rb_iter *rb_iter_alloc           ();
> -struct rb_iter *rb_iter_init            ();
> +struct rb_iter *rb_iter_init            (struct rb_iter *self);
>   struct rb_iter *rb_iter_create          ();
>   void            rb_iter_dealloc         (struct rb_iter *self);
>   void           *rb_iter_first           (struct rb_iter *self, struct rb_tree *tree);
