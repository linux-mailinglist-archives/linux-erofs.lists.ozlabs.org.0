Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BDE8286DF
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Jan 2024 14:10:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T8WWK62PKz2yGv
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jan 2024 00:10:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T8WWG3VQrz30Qk
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jan 2024 00:10:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W-IdcmJ_1704805810;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-IdcmJ_1704805810)
          by smtp.aliyun-inc.com;
          Tue, 09 Jan 2024 21:10:11 +0800
Message-ID: <ad9c2250-2dc9-4515-a3c9-1450e415e6d9@linux.alibaba.com>
Date: Tue, 9 Jan 2024 21:10:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mkfs.erofs is noisy when run with a pipe attached to
 stdout/stderr
To: Daan De Meyer <daan.j.demeyer@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAO8sHcmnq+foWo7AZYbkxJXHfSeZkd73Dq+1dQSZYBE6QxL8JQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAO8sHcmnq+foWo7AZYbkxJXHfSeZkd73Dq+1dQSZYBE6QxL8JQ@mail.gmail.com>
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

Hi Daan,

On 2024/1/9 18:12, Daan De Meyer wrote:
> Hi,
> 
> When executed with a pipe attached to stdout/stderr (for example in
> CI), mkfs.erofs is super verbose as \r doesn't go to the beginning of
> the line so mkfs.erofs will print a separate line for each file in the
> root directory that is passed to mkfs.erofs. Could mkfs.erofs be
> updated to not print a separate line for each file when stdout/stderr
> are not ttys?

Thanks for the report.  It's helpful and let me investigate and fix
the non-tty cases.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Daan De Meyer
