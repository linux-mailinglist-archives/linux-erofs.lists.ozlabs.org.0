Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D472F6A5282
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 06:01:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PQlb725J5z3c9V
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Feb 2023 16:01:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PQlb26QDhz3083
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Feb 2023 16:01:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VchTz00_1677560504;
Received: from 30.97.48.254(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VchTz00_1677560504)
          by smtp.aliyun-inc.com;
          Tue, 28 Feb 2023 13:01:45 +0800
Message-ID: <1f926a20-6b45-137d-4e78-30025ba33574@linux.alibaba.com>
Date: Tue, 28 Feb 2023 13:01:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an
 option
To: Sandeep Dhavale <dhavale@google.com>
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com>
 <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com>
 <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
 <CAB=BE-Svf7TMPs-eA+sVuGtYjVWfKd1Nd_AkA9im4Op7TCLW3g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-Svf7TMPs-eA+sVuGtYjVWfKd1Nd_AkA9im4Op7TCLW3g@mail.gmail.com>
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
Cc: kernel-team@android.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Nathan Huckleberry <nhuck@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2023/2/28 12:47, Sandeep Dhavale via Linux-erofs wrote:
> Hi all,
> I completed the tests and the results are consistent with
> our previous observation. We can see that removing WQ_UNBOUND
> helps but the scheduling latency by using high priority per cpu
> kthreads is even lower. Below is the table.
> 
> |---------------------+-------+-------+------+-------|
> | Table               | avg   | med   | min  | max   |
> |---------------------+-------+-------+------+-------|
> | Default erofs       | 19323 | 19758 | 3986 | 35051 |
> |---------------------+-------+-------+------+-------|
> | !WQ_UNBOUND         | 11202 | 10798 | 3493 | 19822 |
> |---------------------+-------+-------+------+-------|
> | hipri pcpu kthreads | 7182  | 7017  | 2463 | 12300 |
> |---------------------+-------+-------+------+-------|

May I ask did it test with different setup since the test results
in the original commit message are:

+-------------------------+-----------+----------------+---------+
|                         | workqueue | kthread_worker |  diff   |
+-------------------------+-----------+----------------+---------+
| Average (us)            |     15253 |           2914 | -80.89% |
| Median (us)             |     14001 |           2912 | -79.20% |
| Minimum (us)            |      3117 |           1027 | -67.05% |
| Maximum (us)            |     30170 |           3805 | -87.39% |
| Standard deviation (us) |      7166 |            359 |         |
+-------------------------+-----------+----------------+---------+

Otherwise it looks good to me for now, hopefully helpful to Android
users.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> Sandeep.
