Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B117E8919
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Nov 2023 05:03:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SS29W2Xdlz3bw8
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Nov 2023 15:03:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.15; helo=out199-15.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SS29P0nVcz2ys9
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Nov 2023 15:03:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vw6AFnB_1699675368;
Received: from 172.17.2.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vw6AFnB_1699675368)
          by smtp.aliyun-inc.com;
          Sat, 11 Nov 2023 12:02:49 +0800
Message-ID: <33d6a487-5913-fefd-2a45-d8d397e6f6ba@linux.alibaba.com>
Date: Sat, 11 Nov 2023 12:02:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
To: Matthew Wilcox <willy@infradead.org>,
 Andreas Gruenbacher <agruenba@redhat.com>
References: <20231107212643.3490372-1-willy@infradead.org>
 <20231107212643.3490372-3-willy@infradead.org>
 <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>
 <ZU5jx2QeujE+868t@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZU5jx2QeujE+868t@casper.infradead.org>
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
Cc: gfs2@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/11/11 01:09, Matthew Wilcox wrote:
> On Thu, Nov 09, 2023 at 10:50:45PM +0100, Andreas Gruenbacher wrote:
>> On Tue, Nov 7, 2023 at 10:27 PM Matthew Wilcox (Oracle)
>> <willy@infradead.org> wrote:
>>> +static inline void folio_fill_tail(struct folio *folio, size_t offset,
>>> +               const char *from, size_t len)
>>> +{
>>> +       char *to = kmap_local_folio(folio, offset);
>>> +
>>> +       VM_BUG_ON(offset + len > folio_size(folio));
>>> +
>>> +       if (folio_test_highmem(folio)) {
>>> +               size_t max = PAGE_SIZE - offset_in_page(offset);
>>> +
>>> +               while (len > max) {
>>> +                       memcpy(to, from, max);
>>> +                       kunmap_local(to);
>>> +                       len -= max;
>>> +                       from += max;
>>> +                       offset += max;
>>> +                       max = PAGE_SIZE;
>>> +                       to = kmap_local_folio(folio, offset);
>>> +               }
>>> +       }
>>> +
>>> +       memcpy(to, from, len);
>>> +       to = folio_zero_tail(folio, offset, to);
>>
>> This needs to be:
>>
>> to = folio_zero_tail(folio, offset  + len, to + len);
> 
> Oh, wow, that was stupid of me.  I only ran an xfstests against ext4,
> which doesn't exercise this code, not gfs2 or erofs.  Thanks for
> fixing this up.

Assuming that is for the next cycle (no rush), I will also test
this patch and feedback later since I'm now working on other
stuffs.

Thanks,
Gao Xiang
