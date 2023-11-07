Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A79507E32CE
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 03:09:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SPWqG1wL1z2yVG
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Nov 2023 13:08:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SPWq60kzkz2yVG
	for <linux-erofs@lists.ozlabs.org>; Tue,  7 Nov 2023 13:08:47 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vvs9x.H_1699322918;
Received: from 30.97.49.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vvs9x.H_1699322918)
          by smtp.aliyun-inc.com;
          Tue, 07 Nov 2023 10:08:40 +0800
Message-ID: <8f5106d4-eeb5-a1d9-4181-c8b2e470edc6@linux.alibaba.com>
Date: Tue, 7 Nov 2023 10:08:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: Feature Request: Add --offset option to mkfs.erofs
To: =?UTF-8?B?0J/QsNCy0LXQuyDQntGC0YfQtdGA0YbQvtCy?=
 <pavel.otchertsov@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAAxnTOGTD2NkKnBphZ+vEr7NVnWvT0u02E+c8pN8ZVFcXp5uhg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAAxnTOGTD2NkKnBphZ+vEr7NVnWvT0u02E+c8pN8ZVFcXp5uhg@mail.gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2023/11/7 05:15, Павел Отчерцов wrote:
> Dear EROFS Developers,
> 
> I hope this message finds you well. I am reaching out to propose a feature addition to the `erofs-utils` that I believe could benefit many users, including myself.
> 
> As you know, `mksquashfs` offers an `-offset` option which allows users to specify an offset in the file where the filesystem will begin.
> This feature is particularly useful for embedding the SquashFS image into firmware images or other specific scenarios where filesystems must coexist with different data structures in a single image.
> 
> Currently, `mkfs.erofs` does not seem to support an equivalent option, which limits its utility in scenarios similar to those where `mksquashfs` is used.
> The addition of an `--offset` option to `mkfs.erofs` could provide users with the flexibility to specify the starting offset of the filesystem within an image file.
> 
> The syntax for this could be as straightforward as:
> 
> ```sh
> Copy code
> mkfs.erofs --offset=<offset-in-bytes> <destination-img> <source-directory>
> ```
> 
> This feature would align EROFS's functionality more closely with SquashFS, potentially broadening its use cases and adoption.
> 
> Currently, I can achieve a similar result by first creating an image file with the desired offset using `truncate`, and then concatenating the filesystem image to the offset image using `cat`, like so:
> 
> ```sh
> truncate -s <offset-in-bytes> image_with_offset.img
> cat erofs.img >> image_with_offset.img
> ```
> 
> However, this method is more cumbersome and less efficient than having an integrated option in `mkfs.erofs`.
> Implementing an `--offset` option would streamline the process and offer a more elegant and direct approach.
> 
> I understand that such features require time and resources to implement, and I appreciate the effort that goes into maintaining and improving open-source software.
> I believe this feature could enhance EROFS's utility for many users and look forward to any possibility of its inclusion in future releases.
> 
> Thank you for your consideration and for the work you do to develop and maintain EROFS. Please let me know if I can provide further information or assist in any way.

Thanks for the reference! Let's implement this feature.

Thanks,
Gao Xiang

> 
> Best regards,
> Pavel Otchertsov <pavel.otchertsov@gmail.com <mailto:pavel.otchertsov@gmail.com>>
