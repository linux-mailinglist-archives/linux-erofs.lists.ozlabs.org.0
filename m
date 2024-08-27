Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9881595FFF3
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2024 05:48:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WtD5s1YFcz2yRD
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2024 13:48:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724730478;
	cv=none; b=Y4ViCnK9uCdyF+/uJ4ojt2aCyk6zA8KDDmxqtIXc43yhk2ALrsgD9GtZMtrWjN89A/2XNE3KNEByfOJ+RS7GRreWDMKs5J/dsXQ/MHTXutr9/s/HX2vvi4dAlb9DbGfhdE+TgHzztywgd1BmxaJtxSPWcuuLzZlLShydzi89YZvSSL3vZBm5SxtzUOYPLVbzi3r1/9ZnPAJ01bn9bSknJNg8SU2ft8hRrLi2fO4hRkQBB8ntzfUvXF8sh1CxEiijm8CeKqmOzWl9VQRaNf6Ul2bhGR6fQA8uGOSSFVb2JUlGJFaSQDVB7CEcXg216nEDLYad35pUF+mw/Anv31rAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724730478; c=relaxed/relaxed;
	bh=QJdnbHHYMPw5RsyzHB99sp/ysEtaidWqO/onJKNe568=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=EIFgSnSsgso4y83tbdcaMRqxsJ/IMyITdkFKY8W7zv0eaz/4IR/cLf5+VvIdcr4D161KwTYxxtalFH/WLS5YzhqZ/7vKEuEvesZ97Lm194DoMg/gyqBhqh8Sv4iCtUoOivSoBXCRB0rztDBBWvI1i6fWxEoS5ZqEVrGSZJmENimqn00a6hWReuaCR2ls5/3uQU7VuGAoV9sK9z4YjWlN4VgQdASls03Sab/ggcFSVEWmWewIhV4+f9g5iCB5+TeaP6T29NIOcdXmGosY7AYyoBjKF6ofG4Af6ZBQGNEzwx8eUA543/tsNvO88ZDOSGfSdVUNcFRcSKI7ueqALlRmUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WtD5n73rQz2xrk
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2024 13:47:54 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WtD5K12Q5z4f3jM1
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2024 11:47:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A28EB1A058E
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2024 11:47:47 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgB37IJfTM1m5shTCw--.52889S3;
	Tue, 27 Aug 2024 11:47:47 +0800 (CST)
Message-ID: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
Date: Tue, 27 Aug 2024 11:47:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
To: Markus Elfring <Markus.Elfring@web.de>
References: <20240826040018.2990763-1-libaokun@huaweicloud.com>
 <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB37IJfTM1m5shTCw--.52889S3
X-Coremail-Antispam: 1UD129KBjvJXoW7GryUWF4kGw4rZFWUKFyDWrg_yoW8Jr4UpF
	Way3WUKryfWr4UKr4kAa1Fvw1F9397WFs0q3W3Wr9rAan0qryYvr12grn0qF98AryDJr42
	qa1j9a43X3yUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBWbMPH9KgwAAss
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
Cc: Christian Brauner <brauner@kernel.org>, Yang Erkun <yangerkun@huawei.com>, Jeff Layton <jlayton@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, stable@kernel.org, Yu Kuai <yukuai3@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/8/26 21:55, Markus Elfring wrote:
> …
>> Add the missing dput() to cachefiles_open_file() for a quick fix.
> I suggest to use a goto chain accordingly.
>
>
> …

Hi Markus,


Thanks for the suggestion, but I think the current solution is simple
enough that we don't need to add a label to it.

Actually, at first I was going to release the reference count of the
dentry uniformly in cachefiles_look_up_object() and delete all dput()
in cachefiles_open_file(), but this may conflict when backporting
the code to stable. So just keep it simple to facilitate backporting
to stable.

Thanks,
Baokun
>> +++ b/fs/cachefiles/namei.c
>> @@ -554,6 +554,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>>   	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
>>   		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
>>   			  dentry, d_inode(dentry)->i_ino);
>> +		dput(dentry);
>>   		return false;
> Please replace two statements by the statement “goto put_dentry;”.
>
>
> …
>> error:
>> 	cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
> +put_dentry:
>> 	dput(dentry);
>> 	return false;
>> }
> Regards,
> Markus

-- 
With Best Regards,
Baokun Li

