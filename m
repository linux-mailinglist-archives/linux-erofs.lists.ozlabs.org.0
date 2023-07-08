Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62774BCF2
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 11:00:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QykkR3GZvz3bW4
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jul 2023 19:00:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QykkH36gwz2xqp
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jul 2023 19:00:21 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VmrW6mA_1688806814;
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmrW6mA_1688806814)
          by smtp.aliyun-inc.com;
          Sat, 08 Jul 2023 17:00:16 +0800
Message-ID: <97875049-8df9-e041-61ca-d90723ba6e82@linux.alibaba.com>
Date: Sat, 8 Jul 2023 17:00:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs: fix two loop issues when read page beyond EOF
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org, chao@kernel.org
References: <20230708062432.67344-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230708062432.67344-1-guochunhai@vivo.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

On 2023/7/8 14:24, Chunhai Guo wrote:
> When z_erofs_read_folio() reads a page with an offset far beyond EOF, two
> issues may occur:
> - z_erofs_pcluster_readmore() may take a long time to loop when the offset
>    is big enough, which is unnecessary.
>      - For example, it will loop 4691368 times and take about 27 seconds
>        with following case.
>          - offset = 19217289215
>          - inode_size = 1442672
> - z_erofs_do_read_page() may loop infinitely due to the inappropriate
>    truncation in the below statement. Since the offset is 64 bits and
> min_t() truncates the result to 32 bits. The solution is to replace
> unsigned int with another 64-bit type, such as erofs_off_t.
>      cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>      - For example:
>          - offset = 0x400160000
>          - end = 0x370
>          - map->m_la = 0x160370
>          - offset + end - map->m_la = 0x400000000
>          - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)

Thanks for the catch!

Could you split these two into two patches?

how about using:
cur = end - min_t(erofs_off_t, offend + end - map->m_la, end)
for this?

since cur and end are all [0, PAGE_SIZE - 1] for now, and
folio_size() later.

>      - Expected result:
>          - cur = 0
>      - Actual result:
>          - cur = 0x370
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/zdata.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5f1890e309c6..6abbd4510076 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -972,7 +972,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   	struct erofs_map_blocks *const map = &fe->map;
>   	const loff_t offset = page_offset(page);
>   	bool tight = true, exclusive;
> -	unsigned int cur, end, spiltted;
> +	erofs_off_t cur, end;
> +	unsigned int spiltted;
>   	int err = 0;
>   
>   	/* register locked file pages as online pages in pack */
> @@ -1035,7 +1036,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   	 */
>   	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
>   
> -	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
> +	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
>   	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>   		zero_user_segment(page, cur, end);
>   		goto next_part;
> @@ -1841,7 +1842,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>   	}
>   
>   	cur = map->m_la + map->m_llen - 1;
> -	while (cur >= end) {
> +	while ((cur >= end) && (cur < i_size_read(inode))) {
>   		pgoff_t index = cur >> PAGE_SHIFT;
>   		struct page *page;
>   
> @@ -1876,6 +1877,12 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>   	trace_erofs_readpage(page, false);
>   	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
>   
> +	/* when trying to read beyond EOF, return zero page directly */
> +	if (f.headoffset >= i_size_read(inode)) {
> +		zero_user_segment(page, 0, PAGE_SIZE);
> +		return 0;
> +	}
Do we really need to optimize this rare case?
I guess the follow readmore fix is enough, thoughts?


Thanks,
Gao Xiang
