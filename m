Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F75743315
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jun 2023 05:21:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QsgZk5RGKz3bdV
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Jun 2023 13:21:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QsgZd6dMFz3bPG
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Jun 2023 13:21:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VmGYo1U_1688095261;
Received: from 30.13.161.45(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmGYo1U_1688095261)
          by smtp.aliyun-inc.com;
          Fri, 30 Jun 2023 11:21:02 +0800
Message-ID: <bc37b040-701d-3b5a-5cf2-370c320affbb@linux.alibaba.com>
Date: Fri, 30 Jun 2023 11:20:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [Linux-cachefs] [PATCH v7 2/2] mm, netfs, fscache: Stop read
 optimisation when folio removed from pagecache
Content-Language: en-US
To: Xiubo Li <xiubli@redhat.com>, David Howells <dhowells@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
 <41e1c831-29de-8494-d925-6e2eb379567f@redhat.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <41e1c831-29de-8494-d925-6e2eb379567f@redhat.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Shyam Prasad N <nspmangalore@gmail.com>, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Rohith Surabattula <rohiths.msft@gmail.com>, linux-erofs@lists.ozlabs.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-cachefs@redhat.com, v9fs-developer@lists.sourceforge.net, Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 6/29/23 8:39 AM, Xiubo Li wrote:
> 
> On 6/28/23 18:48, David Howells wrote:
>> Fscache has an optimisation by which reads from the cache are skipped
>> until
>> we know that (a) there's data there to be read and (b) that data isn't
>> entirely covered by pages resident in the netfs pagecache.  This is done
>> with two flags manipulated by fscache_note_page_release():
>>
>>     if (...
>>         test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
>>         test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
>>         clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
>>
>> where the NO_DATA_TO_READ flag causes cachefiles_prepare_read() to
>> indicate
>> that netfslib should download from the server or clear the page instead.
>>
>> The fscache_note_page_release() function is intended to be called from
>> ->releasepage() - but that only gets called if PG_private or PG_private_2
>> is set - and currently the former is at the discretion of the network
>> filesystem and the latter is only set whilst a page is being written
>> to the
>> cache, so sometimes we miss clearing the optimisation.
>>
>> Fix this by following Willy's suggestion[1] and adding an address_space
>> flag, AS_RELEASE_ALWAYS, that causes filemap_release_folio() to always
>> call
>> ->release_folio() if it's set, even if PG_private or PG_private_2 aren't
>> set.
>>
>> Note that this would require folio_test_private() and
>> page_has_private() to
>> become more complicated.  To avoid that, in the places[*] where these are
>> used to conditionalise calls to filemap_release_folio() and
>> try_to_release_page(), the tests are removed the those functions just
>> jumped to unconditionally and the test is performed there.
>>
>> [*] There are some exceptions in vmscan.c where the check guards more
>> than
>> just a call to the releaser.  I've added a function,
>> folio_needs_release()
>> to wrap all the checks for that.
>>
>> AS_RELEASE_ALWAYS should be set if a non-NULL cookie is obtained from
>> fscache and cleared in ->evict_inode() before
>> truncate_inode_pages_final()
>> is called.
>>
>> Additionally, the FSCACHE_COOKIE_NO_DATA_TO_READ flag needs to be cleared
>> and the optimisation cancelled if a cachefiles object already contains
>> data
>> when we open it.
>>
>> Fixes: 1f67e6d0b188 ("fscache: Provide a function to note the release
>> of a page")
>> Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
>> Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Matthew Wilcox <willy@infradead.org>
>> cc: Linus Torvalds <torvalds@linux-foundation.org>
>> cc: Steve French <sfrench@samba.org>
>> cc: Shyam Prasad N <nspmangalore@gmail.com>
>> cc: Rohith Surabattula <rohiths.msft@gmail.com>
>> cc: Dave Wysochanski <dwysocha@redhat.com>
>> cc: Dominique Martinet <asmadeus@codewreck.org>
>> cc: Ilya Dryomov <idryomov@gmail.com>
>> cc: linux-cachefs@redhat.com
>> cc: linux-cifs@vger.kernel.org
>> cc: linux-afs@lists.infradead.org
>> cc: v9fs-developer@lists.sourceforge.net
>> cc: ceph-devel@vger.kernel.org
>> cc: linux-nfs@vger.kernel.org
>> cc: linux-fsdevel@vger.kernel.org
>> cc: linux-mm@kvack.org
>> ---
>>
>> Notes:
>>      ver #7)
>>       - Make NFS set AS_RELEASE_ALWAYS.
>>           ver #4)
>>       - Split out merging of
>> folio_has_private()/filemap_release_folio() call
>>         pairs into a preceding patch.
>>       - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
>>           ver #3)
>>       - Fixed mapping_clear_release_always() to use clear_bit() not
>> set_bit().
>>       - Moved a '&&' to the correct line.
>>           ver #2)
>>       - Rewrote entirely according to Willy's suggestion[1].
>>
>>   fs/9p/cache.c           |  2 ++
>>   fs/afs/internal.h       |  2 ++
>>   fs/cachefiles/namei.c   |  2 ++
>>   fs/ceph/cache.c         |  2 ++
>>   fs/nfs/fscache.c        |  3 +++
>>   fs/smb/client/fscache.c |  2 ++
>>   include/linux/pagemap.h | 16 ++++++++++++++++
>>   mm/internal.h           |  5 ++++-
>>   8 files changed, 33 insertions(+), 1 deletion(-)
> 
> Just one question. Shouldn't do this in 'fs/erofs/fscache.c' too ?
> 

Currently the read optimization is not used in fscache ondemand mode
(used by erofs), though it may not be intended...

cachefiles_ondemand_copen
  if (size)
    clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);

The read optimization is disabled as long as the backing file size is
not 0 (which is the most case).  And thus currently erofs doesn't need
to clear FSCACHE_COOKIE_NO_DATA_TO_READ in .release_folio().

-- 
Thanks,
Jingbo
