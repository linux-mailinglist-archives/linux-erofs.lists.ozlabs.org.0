Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA4723BF9
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 10:39:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qb3nL6qV3z3dw4
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jun 2023 18:39:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qb3nJ13Qnz3chN
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 18:39:45 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qb3Y80JgYz9xrdR
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jun 2023 16:29:16 +0800 (CST)
Received: from [10.174.177.238] (unknown [10.174.177.238])
	by APP2 (Coremail) with SMTP id BqC_BwC30GrD8H5kzU9fCA--.21340S2;
	Tue, 06 Jun 2023 08:39:35 +0000 (GMT)
Message-ID: <a7a14b43-f202-5016-cb3a-363e93372759@huaweicloud.com>
Date: Tue, 6 Jun 2023 16:39:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] erofs-utils: dump: add some superblock fields display
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230606035511.1114101-1-guoxuenan@huawei.com>
 <95aeb6f0-348a-81e4-2180-a5dfaa18995f@linux.alibaba.com>
 <c1e01731-9922-e146-2008-b68c22926999@huaweicloud.com>
 <41910cd1-ea8a-cab4-af46-eea76d6f1761@linux.alibaba.com>
From: Guo Xuenan <guoxuenan@huaweicloud.com>
In-Reply-To: <41910cd1-ea8a-cab4-af46-eea76d6f1761@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwC30GrD8H5kzU9fCA--.21340S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKry3Wr1fXFWrAw47Cr45ZFb_yoWDJwc_XF
	y0va1kGr4rJFW7Krs5tr1rAF4DWFWUX3yUJrWqqr4xA3srXayrWr4kJws5uF48Xa18Kwnx
	twnIqa48XryYgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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


On 2023/6/6 15:58, Gao Xiang wrote:
>
>
> On 2023/6/6 15:28, Guo Xuenan wrote:
>
> ...
>
>>>> +
>>>> +struct available_alg {
>>>> +    int type;
>>>> +    const char *name;
>>>> +};
>>>
>>> Could we use lib/compressor.c instead?
>>>
>> Take a look at the currently implemented interface, and I notice that
>> compressor.c define different compressors for mkfs.erofs, but for
>> dump.erofs we don't need care about that much, we only show compression
>>   algothrims name of the image. It seems that it cannot be reused.
>
> Please help add erofsfsck_ prefix to available_cfg like
> erofsfsck_available_cfg.
>
> Anyway, that is still not quite clean if you take a look at
> erofs_get_compress_algorithm_id() if lib/compress.c.
>
Okay, I will  reorganize the code here,  try to address it and send v2 
later.
> We could address this later.
>
> Thanks,
> Gao Xiang

-- 
Guo Xuenan [Confused at thirty]
-----------------------------
Email: guoxuenan@huaweicloud.com

