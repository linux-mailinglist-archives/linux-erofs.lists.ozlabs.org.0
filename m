Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156C4447EC
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Nov 2021 19:08:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hkvrn1HNZz30HX
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Nov 2021 05:08:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=sandeen.net (client-ip=63.231.237.45; helo=sandeen.net;
 envelope-from=sandeen@sandeen.net; receiver=<UNKNOWN>)
X-Greylist: delayed 498 seconds by postgrey-1.36 at boromir;
 Thu, 04 Nov 2021 05:07:55 AEDT
Received: from sandeen.net (sandeen.net [63.231.237.45])
 by lists.ozlabs.org (Postfix) with ESMTP id 4HkvrW0974z2ynt
 for <linux-erofs@lists.ozlabs.org>; Thu,  4 Nov 2021 05:07:54 +1100 (AEDT)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by sandeen.net (Postfix) with ESMTPSA id 2B0BF14627D;
 Wed,  3 Nov 2021 12:57:54 -0500 (CDT)
Message-ID: <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
Date: Wed, 3 Nov 2021 12:59:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
From: Eric Sandeen <sandeen@sandeen.net>
Subject: Re: futher decouple DAX from block devices
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 10/17/21 11:40 PM, Christoph Hellwig wrote:
> Hi Dan,
> 
> this series cleans up and simplifies the association between DAX and block
> devices in preparation of allowing to mount file systems directly on DAX
> devices without a detour through block devices.

Christoph, can I ask what the end game looks like, here? If dax is completely
decoupled from block devices, are there user-visible changes? If I want to
run fs-dax on a pmem device - what do I point mkfs at, if not a block device?

Thanks,
-Eric
