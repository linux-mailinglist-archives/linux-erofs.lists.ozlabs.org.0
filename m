Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84950997B4A
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 05:31:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPFfT1R44z3bkG
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 14:31:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728531087;
	cv=none; b=olKfgPTGe19jHRGE5OUTCmSvJT8ESMb9oU05lgw+Scp541msXhSlQ52J+TQdmEtNDs49O3iPI8VUmwo4TtRDP0SduwYID36JLB5T+uhg691y7WWoF4YCppuQqn+pyif1855GwAj0/cmWnfbBxX16gka5Svce5j51w6Tk0ejqMuaOGLFWfkJlAXcRIEbetg2RVibV2zqb+XqOO7KArrsxGT96ViombXP2L20yn1sg02Vc9Cynmfi97uPZoTL8N04NIrxQrTr0SmKogvI3NBbejseGqOUnUT8A+hq5HJnLy1HmfV7V76xwQm0vVcVy3qz5xVDGzWbbwrkQ+66ewij3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728531087; c=relaxed/relaxed;
	bh=wvKYRrPMNqDfmQ/O3t8Xbz15qAUDwoPYqCFME5Mo35Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECbP4+SUV6z/ywajcuoZeBVj+Vk90ZiattyVlj7SPcgbfyj5Ax0dDiV6Z0DVscQgm3pmQZz/yarezRjXb/iSsfz1lX37n6ePpjbYmmI87u50MGnhaOCqOQcZgwchU2REjDE9yFeZRrJsz5dBGl9TwkyQnC+RvfK1bBVNaF0FwWLOs5TAfvsQt5PItIhXLvZV+ofjFX5hBHj6DdO88EGBKIRv6jNFJHlRP474djgmodqRiiVk6l8y8ez4Y5wZdi9CZfKOk5ai7sY2A5yMLpzyyk9LoHm62YVR85Rcvf5xrqt544T7cbhK5BcM42yRJ1aJPNklMuqP+LvgA5ctNwh3fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fDcQIfq4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fDcQIfq4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPFfL1N9Qz2yDY
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 14:31:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728531074; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wvKYRrPMNqDfmQ/O3t8Xbz15qAUDwoPYqCFME5Mo35Q=;
	b=fDcQIfq45L3wEK7lpzXP/Tj3QeNzcSv90fO4bF3gIijrU9usEzn81XjH89V/IxBsy0f6rvRXnmbwEAS3KSDrBHHvT975r9j53fPErLxskEVogBVot6nViBmJj20WDwM9YKYfQx3SoYA3Wjb3y8ViYUxXYIYClQ6Xl6Fq9pCICgs=
Received: from 30.221.129.194(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGkt5uu_1728531072)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 11:31:13 +0800
Message-ID: <15a74197-9b84-4d73-a770-8bfc2fde7742@linux.alibaba.com>
Date: Thu, 10 Oct 2024 11:31:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] netfs/cachefiles: Some bugfixes
To: Zizhi Wo <wozizhi@huawei.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, brauner@kernel.org
References: <20240821024301.1058918-1-wozizhi@huawei.com>
 <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <827d5f2e-d6a7-43ca-8034-5e2508d89f22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, yukuai3@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Zizhi,

On 2024/10/10 11:08, Zizhi Wo wrote:
> Hi!
> 
> This patchset involves some general cachefiles workflows and the on-
> demand loading process. For example, the eighth patch fixes a memory
> ordering issue in cachefiles, and the fifth patch includes some cleanup.
> These all related to changes in the general cachefiles workflow, and I
> think these deserve some attention.
> 
> Additionally, although the current EROFS on-demand loading mode based on
> cachefiles interaction might be considered for switching to the fanotify
> mode in the future, I believe the code based on the current cachefiles
> on-demand loading mode still requires maintenance. The first few patches
> here are bugfixes specifically for that.

Yes, I also agree with you.  I pinged David weeks ago, because many
bugfixes are not only impacted to cachefiles on-demand feature but
also generic cachefiles, hopefully they could be addressed upstream.

Thanks,
Gao Xiang

> 
> Therefore, I would greatly appreciate it if anyone could take some time
> to review these patches. So friendly ping.
> 
> Thanks,
> Zizhi Wo
> 
> 
> 在 2024/8/21 10:42, Zizhi Wo 写道:
>> Hi!
>>
>> We recently discovered some bugs through self-discovery and testing in
>> erofs ondemand loading mode, and this patchset is mainly used to fix
>> them. These patches are relatively simple changes, and I would be excited
>> to discuss them together with everyone. Below is a brief introduction to
>> each patch:
>>
>> Patch 1: Fix for wrong block_number calculated in ondemand write.
>>
>> Patch 2: Fix for wrong length return value in ondemand write.
>>
>> Patch 3: Fix missing position update in ondemand write, for scenarios
>> involving read-ahead, invoking the write syscall.
>>
>> Patch 4: Previously, the last redundant data was cleared during the umount
>> phase. This patch remove unnecessary data in advance.
>>
>> Patch 5: Code clean up for cachefiles_commit_tmpfile().
>>
>> Patch 6: Modify error return value in cachefiles_daemon_secctx().
>>
>> Patch 7: Fix object->file Null-pointer-dereference problem.
>>
>> Patch 8: Fix for memory out of order in fscache_create_volume().
>>
>>
>> Zizhi Wo (8):
>>    cachefiles: Fix incorrect block calculations in
>>      __cachefiles_prepare_write()
>>    cachefiles: Fix incorrect length return value in
>>      cachefiles_ondemand_fd_write_iter()
>>    cachefiles: Fix missing pos updates in
>>      cachefiles_ondemand_fd_write_iter()
>>    cachefiles: Clear invalid cache data in advance
>>    cachefiles: Clean up in cachefiles_commit_tmpfile()
>>    cachefiles: Modify inappropriate error return value in
>>      cachefiles_daemon_secctx()
>>    cachefiles: Fix NULL pointer dereference in object->file
>>    netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING
>>
>>   fs/cachefiles/daemon.c    |  2 +-
>>   fs/cachefiles/interface.c |  3 +++
>>   fs/cachefiles/io.c        | 10 +++++-----
>>   fs/cachefiles/namei.c     | 23 +++++++++++++----------
>>   fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
>>   fs/netfs/fscache_volume.c |  3 +--
>>   6 files changed, 52 insertions(+), 27 deletions(-)
>>

