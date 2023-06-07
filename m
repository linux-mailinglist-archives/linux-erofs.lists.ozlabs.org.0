Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1C725D49
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Jun 2023 13:38:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QblhY0gbzz3dsn
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Jun 2023 21:38:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QblhT475jz3dqq
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Jun 2023 21:37:58 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QblSJ3Xzbz9y9Cm
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 Jun 2023 19:27:28 +0800 (CST)
Received: from [10.174.177.238] (unknown [10.174.177.238])
	by APP2 (Coremail) with SMTP id BqC_BwCXfogHbIBkygFuCA--.210S2;
	Wed, 07 Jun 2023 11:37:46 +0000 (GMT)
Message-ID: <5931c8c8-b07b-73b8-927d-147bb498b46a@huaweicloud.com>
Date: Wed, 7 Jun 2023 19:37:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] erofs-utils: error out if de_namelen is 0
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230606075125.75125-1-hsiangkao@linux.alibaba.com>
From: Guo Xuenan <guoxuenan@huaweicloud.com>
In-Reply-To: <20230606075125.75125-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: BqC_BwCXfogHbIBkygFuCA--.210S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr18Xw45Wr13Wr4UZryUGFg_yoW3WFX_G3
	y0qwn2vF45JFZ7Z3WrCrs5ZFW5C3Z0qr40yFWrWr45J39xt3W0qws7tFZ3Xa48Xr4j9FZ0
	kF98Jr4vgrya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVWUJVW8JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
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


On 2023/6/6 15:51, Gao Xiang wrote:
> de_namelen 0 is invalid for now.
>
> Fixes: 564adb0a852b ("erofs-utils: lib: add API to iterate dirs in EROFS")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   lib/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/dir.c b/lib/dir.c
> index cb8c188..abbf27a 100644
> --- a/lib/dir.c
> +++ b/lib/dir.c
> @@ -41,7 +41,7 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
>   			break;
>   		}
>   
> -		if (nameoff + de_namelen > maxsize ||
> +		if (nameoff + de_namelen > maxsize || !de_namelen ||
>   				de_namelen > EROFS_NAME_LEN) {
>   			errmsg = "bogus dirent namelen";
>   			break;

Looks reasonable to me.

Reviewed-by: Guo Xuenan <guoxuenan@huaweicloud.com>

-- 
Best regards
Guo Xuenan

