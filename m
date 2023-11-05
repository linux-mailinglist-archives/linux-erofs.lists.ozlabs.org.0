Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688687E135B
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Nov 2023 13:47:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SNZ4X1PBZz3bYx
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Nov 2023 23:47:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SNZ4L3BScz2xdg
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Nov 2023 23:46:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VveWR1j_1699188406;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VveWR1j_1699188406)
          by smtp.aliyun-inc.com;
          Sun, 05 Nov 2023 20:46:48 +0800
Message-ID: <aa00c780-a02d-90ca-a432-f8f1a079f31d@linux.alibaba.com>
Date: Sun, 5 Nov 2023 20:46:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs-utils: mkfs: fix potential memory leak
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20231104065041.129680-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231104065041.129680-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/11/4 14:50, Yifan Zhao wrote:
> Valgrind reports 2 potential memory leaks in mkfs:
> 
>      Command: mkfs.erofs -zlz4 test.img testdir/
> 
>      4 bytes in 1 blocks are still reachable in loss record 1 of 2
>         at 0x4841848: malloc (vg_replace_malloc.c:431)
>         by 0x49633DE: strdup (strdup.c:42)
>         by 0x10C483: mkfs_parse_compress_algs (main.c:287)
>         by 0x10C483: mkfs_parse_options_cfg (main.c:316)
>         by 0x10C483: main (main.c:936)
> 
>      34 bytes in 1 blocks are still reachable in loss record 2 of 2
>         at 0x4841848: malloc (vg_replace_malloc.c:431)
>         by 0x49633DE: strdup (strdup.c:42)
>         by 0x48FFE2B: realpath_stk (canonicalize.c:409)
>         by 0x48FFE2B: realpath@@GLIBC_2.3 (canonicalize.c:431)
>         by 0x10B7EB: mkfs_parse_options_cfg (main.c:587)
>         by 0x10B7EB: main (main.c:936)
> 
> Fix it by freeing the memory allocated by strdup() and realpath().
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

BTW, would you mind adding a configuration to enable Valgrind?

Thanks,
Gao Xiang
