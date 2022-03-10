Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05B4D41B8
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 08:22:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KDgWJ6qgVz306D
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Mar 2022 18:22:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KDgWB6GCpz2xVn
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 18:22:27 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V6nmVdd_1646896938; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6nmVdd_1646896938) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Mar 2022 15:22:20 +0800
Date: Thu, 10 Mar 2022 15:22:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: =?utf-8?B?5YiY6YeR5a6d?= <liujinbao1@xiaomi.com>
Subject: Re: [erofs-utils] Report two resource leak issues and submit patches
Message-ID: <YimnKtK+uhcwNLzL@B-P7TQMD6M-0146.local>
References: <7edd65f3347a4105b54cac65140ae06a@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7edd65f3347a4105b54cac65140ae06a@xiaomi.com>
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
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 Jianhua1 Hao =?utf-8?B?6YOd5bu65Y2O?= <haojianhua1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Thu, Mar 10, 2022 at 07:06:49AM +0000, 刘金宝 via Linux-erofs wrote:
> Hello,
> There are two resource leak problems and patches here.
> Problem 1: Resource leakage
> File: erofs-utils/lib/xattr.c
> Function: erofs_get_selabel_xattr
> Statement: ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
> if (ret <= 0)
> return ERR_PTR(-ENOMEM);
> Analysis: When the asprintf function fails, it returns -1, so the judgment condition should be ret<0. Return when ret=0, the storage pointed to by fspath will be leaked
> Patch: if (ret < 0)
> 
> Problem 2: Resource leakage
> File: erofs-utils/lib/inode.c
> Function: erofs_droid_inode_fsconfig
> Statement: if (asprintf(&decorated, "%s/%s", cfg.mount_point, erofs_fspath(path)) <= 0)
> return -ENOMEM;
> Analysis: When the asprintf function fails, it returns -1, so the judgment condition should be ret<0. Return when asprintf(&decorated, "%s/%s", cfg.mount_point, erofs_fspath(path)) = 0, the storage pointed to by decorated will be leaked
> Patch: if (asprintf(&decorated, "%s/%s", cfg.mount_point, erofs_fspath(path)) < 0)
> 

Thanks for the report!

Since you already have solutions, would you mind submitting
2 independent patches for these?

Thanks,
Gao Xiang

> Thank you!
> Jinbao Liu
> 
> 
> 
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
