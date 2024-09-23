Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3197E4E8
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 05:03:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBnrS4zGsz2yT0
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 13:03:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727060630;
	cv=none; b=bpb451Yszi3GWmwTkL6nhqoH9HwVfoM5M9mTv0vKuX4M5sZLfXC53egxkQrgZokxYJMJaqDeZ0loX7sEKAATC5J16tYW5Mz1gIaG+FcbkRc/706qpWKNbfbrGc+lEbV9PVzMgorvIL05MKDKqEj6OaG0WYliU0eQIs2yUCs2NxZlZHxANFto9jQ7njDBgtgYjOvXVIsnQYa3PBC27Duglm8JTXVQxHeLDAlHzJll7nRzXkV96D+KDpww76P0IY+repFxJFf5yaWlgi+9qS2YLPuUcW5nzUNOTE4aXa4thG88rxvm5xtdEdqWp/gO4nTwFSOdE6nYOvcLV1S6U/t30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727060630; c=relaxed/relaxed;
	bh=aoqURowIyYFZP27+JQuyTZgFvZ2kq5r6bOtMs4frvOY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hFoWXMxHMyifUw9i3zJqgnGaFX5oRmI4EFivrMahHriziGKAxH23UPAemJBsqhpa/mfNqWWNAJi43m7dWJA01FCecmgZ46Lj2z2bzxW3/7dFOS9fjCK6oRTJ0U1/QF+DKnsBP6PVrOVZaZByRvXetND39b//bm1wJ1T1U1nCBZaT6/oPjrqS0ChAdC/Yen9mF2eQVMjShUo3e8HGj5TIRZYktUDn+fRhsxaccR4ilJADfgE+2wtcZk6h/vXdCIsVh2IHJs+56B1wKit03rhDyoBsKgcl9Rm9sllImflElLoxY/mpQyuyTlZ+KtM9U+etcS1cb5ir7Ej1M8KUMJFyvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SfcDJQ9N; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SfcDJQ9N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBnrN0xPCz2xxw
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 13:03:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727060620; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=aoqURowIyYFZP27+JQuyTZgFvZ2kq5r6bOtMs4frvOY=;
	b=SfcDJQ9NOkYS/zCM4VUxKBeqqfCs6lxi5tFbwcSs2Iyn2+IDywiOX1rSFLROaxmP2+ivfm54QQwGLMR/qbX2H6iQIctKEFmEjRpfBouTnytNrFsxgSkLjUHRR/1MK9EBYlzQqOHZ6ltlCbutMYh9SLXzbEHYZipurWBKsCYfzyA=
Received: from 30.27.108.50(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFS5C2j_1727060617)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 11:03:39 +0800
Message-ID: <2ada73ab-66c2-437c-bbc2-fd07cb42c265@linux.alibaba.com>
Date: Mon, 23 Sep 2024 11:03:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix compressed packed inodes
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Danny Lin <danny@orbstack.dev>, linux-erofs@lists.ozlabs.org
References: <20240916073835.77470-1-danny@orbstack.dev>
 <CAEFvpLe92-nS+4zOv5a=UOMW2whBtsGZ98D_MHv+x_KujEaroQ@mail.gmail.com>
 <63307dbc-da27-42e6-86fb-ed446f04ede5@linux.alibaba.com>
In-Reply-To: <63307dbc-da27-42e6-86fb-ed446f04ede5@linux.alibaba.com>
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

Hi Danny,

On 2024/9/23 08:08, Gao Xiang wrote:
> Hi Danny,
> 
> Thanks for the patch!
> Sorry I somewhat missed the previous email..
> 
> On 2024/9/22 13:08, Danny Lin wrote:
>> Gentle bump — let me know if anything needs to be changed!
> 
> Does the following change resolve the issue too?
> 
> Also I think it
> Fixes: 2fdbd28ad4a3 ("erofs-utils: lib: fix uncompressed packed inode")
> 
> @@ -1927,7 +1926,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_sb_info *sbi,
> 
>                  DBG_BUGON(!ictx);
>                  ret = erofs_write_compressed_file(ictx);
> -               if (ret && ret != -ENOSPC)
> +               if (ret != -ENOSPC)
>                           return ERR_PTR(ret);
> 
>                  ret = lseek(fd, 0, SEEK_SET);

Add some more words, I'm on releasing erofs-utils 1.8.2
this week.

So if the diff above also fixes the issue, could you
submit a patch for this so I could merge in time?

Thanks,
Gsao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Danny

