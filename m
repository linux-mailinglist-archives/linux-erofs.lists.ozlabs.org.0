Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E266F80E9
	for <lists+linux-erofs@lfdr.de>; Fri,  5 May 2023 12:40:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QCRzb0X0Xz3cj6
	for <lists+linux-erofs@lfdr.de>; Fri,  5 May 2023 20:40:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QCRzV6dSQz3cMj
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 May 2023 20:40:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vhp0B3X_1683283229;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vhp0B3X_1683283229)
          by smtp.aliyun-inc.com;
          Fri, 05 May 2023 18:40:30 +0800
Message-ID: <49735bd0-2897-c918-8692-eb8702921e77@linux.alibaba.com>
Date: Fri, 5 May 2023 18:40:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: =?UTF-8?B?UmU6IGVyb2Zz5pawZmVhdHVyZS3ljovnvKnlubbljrvph40=?=
To: =?UTF-8?B?5a2Z5aOr5p2w?= <sunshijie@xiaomi.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <9d8fc832ec934a34bcf4d4d0f334a631@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9d8fc832ec934a34bcf4d4d0f334a631@xiaomi.com>
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
Cc: =?UTF-8?B?Smlhbmh1YTEgSGFvIOmDneW7uuWNjg==?= <haojianhua1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/5/5 14:32, 孙士杰 wrote:
>          高翔 老师、各位老师，大家好！
> 
> 
>          为了 erofs 存储精简，进一步减少 erofs 存储空间大小，基于 android13/linux-5.15.41 开发了压缩并去重的feature，新 feature 分为 mkfs.erofs 和 linux 内核 erofs 两部分；
> 
> 
> 一、mkfs.erofs 工具侧大致思路如下：
> 
>          mkfs.erofs 制作镜像时，layout采用 EROFS_INODE_FLAT_COMPRESSION_LEGACY，先压缩，然后对压缩后的数据块去重，
> 
> 对于重复的压缩数据块，更新 decompressed index 中的 blkaddr，不做实际blk_write，从而进一步减少 erofs 的 imgae 大小；

One question:

Did you ever check the compressed deduplication feature introduced in v6.1
with erofs-utils 1.6?

  -Ededupe

Thanks,
Gao Xiang

> 
> 
> 二、linux 内核 erofs 侧大致思路如下：
> 
>          1、重构 z_erofs_collection、z_erofs_pcluster 数据结构，重构后的 z_erofs_collection 是  decompressed 相关属性的抽象，比如pageofs、nr_pages、vcnt、length、pagevec等，去重后为了唯一确定一个 decompressed index，又新增了i_ino、m_la等属性，内部通过 z_erofs_pcluster 指针关联所属的压缩数据块 pcl；
> 
>        重构后的 z_erofs_pcluster 是压缩数据块相关属性的抽象，比如：obj、pclusterpages、compressed_pages等，重构后 z_erofs_pcluster 和 z_erofs_collection 不再是一对一的关系，而是一对N的关系，z_erofs_pcluster 内部通过 list 管理重复压缩数据块对应的 z_erofs_collection；
> 
>        2、重构 collector、submit bio、decompress 等相关代码，比如：通过 index 查找到 erofs_workgroup 后，还要结合 i_ino、m_la 才可以唯一确定一个 z_erofs_collection；比如：解压缩时，pcl 依次对 z_erofs_pcluster 中的 N 个 z_erofs_collection 解压缩(z_erofs_collection 中 nr_pages 不为 0 ，说明还未解压缩，则解压缩之)，最后再标记 Z_EROFS_PCLUSTER_NIL，解锁z_erofs_pcluster ，同时调整 mutex 锁的位置，以实现collector、submit bio、decompress 间的同步；
> 
>        3、重构 z_erofs_rcu_callback 相关代码，实现 z_erofs_collection 、z_erofs_pcluster 等的同步回收和释放；
> 
> 
> 三、该feature需要关闭inplace io；
> 
> 
> 四、feature 相关完整的开发代码详见附件，通过宏定义 CONFIG_EROFS_DUP_ON_COMPRESS 区分；
> 
> 
> 谢谢；
> 
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
