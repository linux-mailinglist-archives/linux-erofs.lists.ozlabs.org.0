Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E7881436FF1
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 04:28:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hb7Z52QBBz3c7W
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Oct 2021 13:28:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=squashfs.org.uk
 (client-ip=72.167.218.97; helo=p3plwbeout02-04.prod.phx3.secureserver.net;
 envelope-from=phillip@squashfs.org.uk; receiver=<UNKNOWN>)
X-Greylist: delayed 986 seconds by postgrey-1.36 at boromir;
 Fri, 22 Oct 2021 13:28:23 AEDT
Received: from p3plwbeout02-04.prod.phx3.secureserver.net
 (p3plsmtp02-04-2.prod.phx3.secureserver.net [72.167.218.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hb7Yz1Wjwz2yfn
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Oct 2021 13:28:22 +1100 (AEDT)
Received: from mailex.mailcore.me ([94.136.40.144]) by :WBEOUT: with ESMTP
 id djzXmVOBMnZYldjzYm9kRH; Thu, 21 Oct 2021 19:09:08 -0700
X-CMAE-Analysis: v=2.4 cv=ApUrYMxP c=1 sm=1 tr=0 ts=61721d44
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10 a=JfrnYn6hAAAA:8
 a=qzs_ciw9LVpZ-E7SRj0A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID: djzXmVOBMnZYl
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175]
 helo=[192.168.178.33])
 by smtp06.mailcore.me with esmtpa (Exim 4.94.2)
 (envelope-from <phillip@squashfs.org.uk>)
 id 1mdjzW-00029M-HX; Fri, 22 Oct 2021 03:09:07 +0100
Subject: Re: Readahead for compressed data
To: Phillip Susi <phill@thesusis.net>, Matthew Wilcox <willy@infradead.org>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
From: Phillip Lougher <phillip@squashfs.org.uk>
Message-ID: <ea03d018-b9ef-9eed-c382-e1a3db7e4e5f@squashfs.org.uk>
Date: Fri, 22 Oct 2021 03:09:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87tuh9n9w2.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated: phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfL2swt08NR18SxcrHxG5kMTq1iDZRIpQKqcEkK6EuN8hoI+YrPzqVYHngAyFldunOdSpsyDWPdHnr/sBotBaPISfGlV501Jz9EsftWQcaDUvrqosPNYn
 HUKPBbx6N7pZW6Bo4piTReKNvGLgviX7TXULKJwk+tacbLGZ+xmmHYyfq0bENFIzYJjoUO8P/T5+tzI/UdnoYW3BORLhDHWQ3vg=
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
Cc: Jan Kara <jack@suse.cz>, linux-ntfs-dev@lists.sourceforge.net,
 David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 22/10/2021 02:04, Phillip Susi wrote:
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
>> As far as I can tell, the following filesystems support compressed data:
>>
>> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
>>
>> I'd like to make it easier and more efficient for filesystems to
>> implement compressed data.  There are a lot of approaches in use today,
>> but none of them seem quite right to me.  I'm going to lay out a few
>> design considerations next and then propose a solution.  Feel free to
>> tell me I've got the constraints wrong, or suggest alternative solutions.
>>
>> When we call ->readahead from the VFS, the VFS has decided which pages
>> are going to be the most useful to bring in, but it doesn't know how
>> pages are bundled together into blocks.  As I've learned from talking to
>> Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
>> something we can teach the VFS.
>>
>> We (David) added readahead_expand() recently to let the filesystem
>> opportunistically add pages to the page cache "around" the area requested
>> by the VFS.  That reduces the number of times the filesystem has to
>> decompress the same block.  But it can fail (due to memory allocation
>> failures or pages already being present in the cache).  So filesystems
>> still have to implement some kind of fallback.
> 
> Wouldn't it be better to keep the *compressed* data in the cache and
> decompress it multiple times if needed rather than decompress it once
> and cache the decompressed data?  You would use more CPU time
> decompressing multiple times

There is a fairly obvious problem here.   A malicious attacker could
"trick" the filesystem into endlessly decompressing the same blocks,
which because the compressed data is cached, could cause it to use
all CPU, and cause a DOS attack.  Caching the uncompressed data prevents
these decompression attacks from occurring so easily.

Phillip


