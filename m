Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B5974E0E
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 11:10:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X3ZXk0XFNz2ykf
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Sep 2024 19:10:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726045812;
	cv=none; b=AKr/1OibICiACAKP+800/3eMG2tOQ4Iji8ptD6xCq6vJfTWcynm8mNKVjQVWwPIJmlkuNpRZQqQUsB4aO4wvUjDeTB94ziVXz0h2M1NgRhiTf3oNJpq5Dm+tDxfy7lySJX75UQDaZeb+DXLKqp1HcwkoYM4BKp1cY5dhQwZzzLYdtW3LWWvmEgLGx2u6ICoTAD+0vY1tifkeMCMKcAmlD6VXvX8xMbUgiWH9bD0++6JZ1xahIIxIKY7KY78qUqWXcxBQCOHokehDPvJedi+lj7YsvKpaK7/Q25ZejyYxk1vfRqb7TVY0X/zfWSmULNJccBNcdUqKmPXU6nEKOhfodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726045812; c=relaxed/relaxed;
	bh=6GBalTn99XOki/SPNwAXzWOmyQ01BL3VEvDM3bVtpKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=obbrE07GnTGKy8eV2CUieVw7Y5t0PifeiiG6AD3xGRJfX+njOD7heUF2pd/ZpdH3ClQoN5MC2S05HVzCr2fTO86QVRRPlVdAenQaXth19D+tYH7awcouEjp8Fo6XPErbPcHtj3Lu2aXV+DwrgUITkqAGdXAHkRLHapQqiXsKbMFuDNffxH5hf3Xe64zUDxs+V6p2tEF9k8zBONi3Lj29Gjef7I3Qli00Ct6DnlIANjizIH0bbq5vW8al4+9aVdrsJvyWNnbSDiZtGZdf2vwZsIAkGJDlvoJz2j5diiNlJ2MuuhJe6cxphwTu9fFtL2qmKBpp+O8gNsRoQpT9lmzaSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dC/pQjh6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dC/pQjh6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X3ZXg3vH3z2xQD
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Sep 2024 19:10:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726045807; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6GBalTn99XOki/SPNwAXzWOmyQ01BL3VEvDM3bVtpKU=;
	b=dC/pQjh6UjDNSOFzbtiMsFU6Y5HzJvVDuHttnnk8He2sXOtrB+qfZ96k0Hsd0Avm/i+O8v7Dk/OMBG8ZScbG/rvdSJ73RIgD2auJp+x8P1Ig/zpjelyfFKQZXAglZw5ftxDzsFkvvj4TcklMvutTxTFfA5TYD7EbnmeOYdw310w=
Received: from 30.221.132.109(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEnSqa._1726045805)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 17:10:06 +0800
Message-ID: <db1bbf20-83b5-4b66-a771-ea08d28117a6@linux.alibaba.com>
Date: Wed, 11 Sep 2024 17:10:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs-utils: lib: fix incorrect nblocks in block list
 for chunked inodes
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240911085531.2133723-1-hongzhen@linux.alibaba.com>
 <b5f151d1-d29a-44f2-8601-5943e717cd07@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <b5f151d1-d29a-44f2-8601-5943e717cd07@linux.alibaba.com>
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


On 2024/9/11 17:04, Gao Xiang wrote:
>
>
> On 2024/9/11 16:55, Hongzhen Luo wrote:
>> Currently, the number of physical blocks (nblocks) for the last chunk
>> written to the block list file is incorrectly recorded as the inode
>> chunksize.
>>
>> This patch writes the actual number of physical blocks for the inode in
>> the last chunk to the block list file.
>
> You should attach "Fixes:" tags here as I previously suggested.
> I will manually add for this time.
>
Sure, I will do it this way in the future.

Thanks,

Hongzhen Luo

>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>
> Otherwise it looks good to me.
>
> Thanks,
> Gao Xiang
